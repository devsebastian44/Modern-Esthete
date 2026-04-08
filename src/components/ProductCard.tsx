"use client";

import Link from "next/link";
import Image from "next/image";
import { useCart } from "@/context/CartContext";

interface ProductCardProps {
    id: string | number;
    image: string;
    category: string;
    name: string;
    price: number | string;
    originalPrice?: number | string;
    new?: boolean;
    sizes?: string[];
}

export default function ProductCard(props: ProductCardProps) {
    const { addToCart } = useCart();

    return (
        <div className="group relative">
            <Link href={`/shop/${props.id}`} className="block">
                <div className="relative aspect-[3/4] overflow-hidden rounded-xl bg-[#f6f7f8] mb-4">
                    <Image
                        src={props.image}
                        alt={props.name}
                        fill
                        className="object-cover object-center transition-transform duration-700 group-hover:scale-110"
                    />
                    {/* Quick Add Button - Inside image container */}
                    <div className="absolute inset-x-6 bottom-6 translate-y-4 group-hover:translate-y-0 opacity-0 group-hover:opacity-100 transition-all duration-300 z-10">
                        <button
                            onClick={(e) => {
                                e.preventDefault();
                                e.stopPropagation();
                                addToCart({
                                    id: props.id,
                                    name: props.name,
                                    price: typeof props.price === 'string' ? parseFloat(props.price.replace(/\$/g, '')) : props.price,
                                    image: props.image,
                                    category: props.category
                                });
                            }}
                            className="w-full bg-white/90 backdrop-blur-md text-[#0a0a0a] py-3.5 rounded-full font-bold text-xs shadow-lg hover:bg-white transition-all duration-300"
                        >
                            Quick Add +
                        </button>
                    </div>
                </div>
            </Link>

            <Link href={`/shop/${props.id}`} className="block">
                <div className="space-y-1">
                    <p className="text-[10px] text-zinc-400 font-bold uppercase tracking-[0.1em]">
                        {props.category}
                    </p>
                    <h3 className="font-bold text-base text-[#0a0a0a]">
                        {props.name}
                    </h3>
                    <div className="flex items-center gap-1">
                        <span className="text-black font-bold text-sm">
                            ${typeof props.price === 'number' ? props.price.toFixed(2) : props.price}
                        </span>
                    </div>
                </div>
            </Link>
        </div>
    );
}

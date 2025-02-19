Return-Path: <linux-kernel+bounces-522506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452F1A3CB30
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D1E3BD80A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8563E253F28;
	Wed, 19 Feb 2025 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0+nPVvr"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA27215053;
	Wed, 19 Feb 2025 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999633; cv=none; b=H0ga5WI9zH5t+QfL9tnaBgYJwP4jZ/orLBrpCECtVUYoXQ4qr3ccPlm+7+huNkmD7pFwmEDeSfZlhXtKOXtqIlon3REokOZYFarY5CvEvzKVNPf2fgKM02rB6OzTtphfuzAmfw+UrjJ+puukCfZzNpT804h7aRpuRP0HWg6+DYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999633; c=relaxed/simple;
	bh=lSSbrTM+qaVy5gjzZWvFzr5yPEYw4GYtpL3eQRHOJtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf1VXv1gANm0bfHNDjQPStEir6VT8Ezk2znVepZIcrL0exkpEb8VwGMqNh4ZQY+KHlhrGSr1TB+vvpQJEBB3ZE8uwG4gXBTiC/dtiJoSBx0BGlpN6R/lMJ71bKWZV2V+i+rSbK6jtSXK7gPh3scDLaIG1K1pEtXN9qf4+ngKx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0+nPVvr; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471f257f763so2375901cf.0;
        Wed, 19 Feb 2025 13:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739999631; x=1740604431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UEtgtgjFKuU2mqNbLxQsl4J63Z11kUn2+Tov8KjoNU=;
        b=L0+nPVvrW81FsfmWAdzoUtsj2emNUipIoOoDMZDfeMwF1NVl/UE+VWfYSKEwRpb4D4
         YuhfBlERo/pVe0qAfu3i2pXUOZXyztZR7NVqimbMvD9XQkqXNF3RHkAbbqaDPYc1zpE6
         bAuJQD08jAeYLzxjIyuvYQxGPdtiN43+47Feq4wLPlDOIyn4jH/a54WL1lcHh3rHcIpZ
         49aUEQo52WL79b4yygGHtlKkemsdIVJ8nDBf4FuxN84aFf6qRXEBfOL2tBNoQZ/xH4O9
         i/yH4/PrQx9g2xTol4z4zpgOp6k9uAq4KxYypCIX31OE5rQW/J32zRBtQArgrjEUQ4gD
         mc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739999631; x=1740604431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UEtgtgjFKuU2mqNbLxQsl4J63Z11kUn2+Tov8KjoNU=;
        b=JYIO94+MsPhrkwpswxB+WTXehcsGp54hAqm/1Q9OzE7CnxxjZ+32vNZ7u2wWsgVtXV
         ktxwKmKU7n+B8u821GkFWrrXusdjoeRZA0bKV8VB3XkHuBhAi9iwgMOia8PSrW244jse
         bHsox83rcnkXyXyptZuep8QOIHykPOIiUgn4QsHFRfnSAnUfzOC2YZ179caKSZAQunJ0
         06h+NsGhsjq6Xjh6d6yUeCQkjR3+mjeVsmm43mMss6njD1NJjlZMjXc0I66u1ItMDD34
         k20s29jz3jiDK1Ai6sE2jSmgKjQcfEgqffSvo5T+1fdJhC/nBOMX2HnB5v3DdXotQ/9u
         rnKg==
X-Forwarded-Encrypted: i=1; AJvYcCUlXaJwzpglfg0Vx7U9cdGd/OyMEHJkEI3uaEZJUpwxuADVoe7BWdgIqtNv6K6ko+2zeQqmnXv3YoUiMHU=@vger.kernel.org, AJvYcCXAfcIaXBod6e3Ru5EgBupgpCims8ileI/HNpCDAUBxVneN7Rx4hExpvwrKeAZaM8M2sGh/6qzO/VgV3Ap1wOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5no7lUtYOeu8aBJLIXyynAI3gRl36m/4HT6N8ICKcktbnLNuW
	B0IPqxPT0sAb7D9vu13lInTB7Y94i5thC+6IsCbDza0LJFlEGxpJ
X-Gm-Gg: ASbGncuxEo8LTPxqy7ZAryFbdGoLWOcoq2K7GON131mVI8fGgamWUbDFisIcfMyvcNO
	eKdtF6c0SDfQ2IqyYboQ7vRe3UdPn4HUShXrVhN/JsEDUBrP2rYpbNcvzmXhAmCzd2VSWdJXtZj
	/fq13wZc5Vlx1iKi2QxUSbjLDnXGNEFmKnAhANFXUFT0Obf5KhUc4qySEHlRjWDc0OAkVatFhn1
	iXrOmf9FHTOEmB/YIDHm25odp/WiyINd8hVFi1bpz8yk9x+5ygvQhEdET+Rzx9jg16+jwlRTx5I
	VtNznZZ7E1YK1lJMrDV7numhUDjTpVIZYmVN6W1YH8xyaYeoo8lMxkBPpHIW+2QI05drvhwPulJ
	v4e0wwA==
X-Google-Smtp-Source: AGHT+IH2Icwhd02IK9xmUcKRmTuo/4jpPveatuGNQiDPDt/Pa8YWoS+4QpPS8i7dTOQGGmRsN5nGVg==
X-Received: by 2002:a05:622a:8f02:b0:471:f730:20bf with SMTP id d75a77b69052e-471f73027c9mr98505041cf.12.1739999631180;
        Wed, 19 Feb 2025 13:13:51 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720028b6c7sm24251061cf.49.2025.02.19.13.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 13:13:50 -0800 (PST)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfauth.phl.internal (Postfix) with ESMTP id 190B71200076;
	Wed, 19 Feb 2025 16:13:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Wed, 19 Feb 2025 16:13:50 -0500
X-ME-Sender: <xms:jUm2Z312AZCp1KjzAS4IcXDcoREbWwG3SjiUp3uZpFsl74bZrC7nLw>
    <xme:jkm2Z2HdRYrYNcAHTqf-2RS4M8NCwMVrRzkffAettKtxIInuq70iCC9mjaNz8-t7m
    SkMHHOx2oeABvymKg>
X-ME-Received: <xmr:jkm2Z37AcM9HsmSoQilQHs6aHkWhknLe_WUksBdDcUitjQUZQci1NNpDw6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiheefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpd
    hrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgig
    rdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopegsjhhorhhnfegpghhhse
    hprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhes
    phhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepthhmghhrohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopegurghkrheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jkm2Z82V_pyhzgwlMtDE01DB-NC4tWsqRbhFo8fa7Os4dwndqoEM4w>
    <xmx:jkm2Z6G6O64s8VzMBUr6iEYpKuNCy7mgV591BbcJwpNnmnDivYLm1A>
    <xmx:jkm2Z9-4bQRMpjve955ZuVQX6xbj3YA2ycLQ_n8rJDbSzn06sU1Blw>
    <xmx:jkm2Z3miAbn_MpCjAsc0SaWpK7yqBt07uUaFJlB0qd4q1m1hI2T-SA>
    <xmx:jkm2Z2Gw5_twPGDTa2k4G9eukneKokb9koPoBNBkZxZFCZMAinQuztf3>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 16:13:49 -0500 (EST)
Date: Wed, 19 Feb 2025 13:13:25 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] MAINTAINERS: update atomic infrastructure entry
 to include Rust
Message-ID: <Z7ZJdZpvhMii9y1L@boqun-archlinux>
References: <20250219201602.1898383-1-gary@garyguo.net>
 <20250219201602.1898383-5-gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219201602.1898383-5-gary@garyguo.net>

Hi,

On Wed, Feb 19, 2025 at 08:15:33PM +0000, Gary Guo wrote:
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Thanks for doing this! 

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Maybe you could add a few things in the commit log, since you're adding
yourself as a reviewer, feel free to add things like:

"I would like to help review atomic related patches, especially Rust
related ones, hence add myself as an reviewer".

I.e. you could mention the areas you will help review ;-)

Regards,
Boqun

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8d9e8187eb0..55d303633598 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3725,12 +3725,14 @@ M:	Will Deacon <will@kernel.org>
>  M:	Peter Zijlstra <peterz@infradead.org>
>  R:	Boqun Feng <boqun.feng@gmail.com>
>  R:	Mark Rutland <mark.rutland@arm.com>
> +R:	Gary Guo <gary@garyguo.net>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/atomic_*.txt
>  F:	arch/*/include/asm/atomic*.h
>  F:	include/*/atomic*.h
>  F:	include/linux/refcount.h
> +F:	rust/kernel/sync/refcount.rs
>  F:	scripts/atomic/
>  
>  ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
> -- 
> 2.47.2
> 


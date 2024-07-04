Return-Path: <linux-kernel+bounces-241753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C7D927F26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810B11C21D64
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 23:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108B8143C75;
	Thu,  4 Jul 2024 23:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMVOb0wA"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895D1448C4;
	Thu,  4 Jul 2024 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720135703; cv=none; b=uUlcl6FfgQeSMlxh8YfPtdIGsdlnlSL1vNjOiOADp0kvVe3PmhsZK3aleVKfIqatw55Gl9i5TiWDxf7pjhdHZQh9R9xctdYBVfrpXDuYmlfa+gqQfq8ilX2M6e3bm0BOSN1evFTbMmk/S/Nkn9Le/vrICMCJKouzAhKGa9Cf7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720135703; c=relaxed/simple;
	bh=4ChXLguW+2pMi3d75KHhO/nrNWKNV8YcLwL1Y9sHL+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+HxaVgNXY26vRubXnpw2rU2c1lYFYDEPhoXQORMYPKx6q5C2BxjNNTlh8mrChObBiIk+OKrPpO1yOZ1f/14KyWdrphzqFv/QiUNdq8OLHw4/GPYlIODzBAdjIELQug8TEn46BYVPGB9x5zz/QdEtizfECBkVtn2mK4lw/fFLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMVOb0wA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-445ae4cfe5aso7283621cf.0;
        Thu, 04 Jul 2024 16:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720135700; x=1720740500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rClBWMkmhU/pqumdRkY19r5BVrEBuYzqIsAB0BJEv1s=;
        b=gMVOb0wAhyzVolBIJbXzw6NxFmyLE0bZg7wwu+673HG7abLGokcn8ExNlWKWTwR7yI
         GYv1an9hkRMHb4WMoOQqjYQfKjlmI97cbmXKsXsi+ttIGoE82EI0uv8H82jvldKWB9yD
         a8eYxiWLpUmOQxSVaRjOjjI0mDWOjuZfsgZCkYG4D+DkYY6GDj1PWhlVfMIRs0wq4avC
         j5/S5AyiodMpUNisFSqgyvROwFRuHJ2AhD9uHhwsowWMHHMsTMkBTj8Z9wvL0DbuneHw
         CDMDaPE1Q3/bB6UQyH/36UNpfWKUmxQMNEMurJOu4rdycdZhiGqH9jNBGV+FNUMsHWNA
         xDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720135700; x=1720740500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rClBWMkmhU/pqumdRkY19r5BVrEBuYzqIsAB0BJEv1s=;
        b=vusNmIKQLLX3lgnhhK8VkFMqCWP4RwDM/ioMjyQ/98Nk1SRyx/PHLF+3WS0jZQ2Al/
         VwAI8nBTsEbObaByxC8z7pH0pTius26Ao41lopuymtRpRfhx3jgwnPbl4fM8D5uvwJVg
         9QCFuTrjsmjFwtsb2U4GsnrHCdOs7gxmQyD+I3jIFmNKrajKgR29Jzqbn2va5zaxJ1LQ
         RAh12WJeogZa83ZXwGfj5N/LnDJFugjSuFutr7KIAfhxaQyeUrU2mZTEctgwDqdLnhWM
         ajxDwX3VJCox3VaBUx8BPtBTUmJ71Nyj9BLY7gtHFExhYrvaP4IF36glyKaa2NlOk5yL
         tyUA==
X-Forwarded-Encrypted: i=1; AJvYcCWw/CVKT6SIuXfv62SAW0GkiWPhDF1XBTjnLloX8L9gjsJ6QGMKZsCHETjS7M3gy76BxM9sXbsx0PKs9KeEuTHv+f10W8u716o7/sUo3vQQxuFbZo2qvdX69Y474pXHYnzy/ukHPZR08KYYz74=
X-Gm-Message-State: AOJu0Yzh0m2rH31lPOPPlf0nqDPERCSeWWr6a21xGLaAQhpKeohff+vk
	sfru169qA6HlfQxQZY0FXyHReAYGDtCUMVylnzdJKBngAIitTwJn
X-Google-Smtp-Source: AGHT+IHveU9QZ1M4+xwFSJBo4+nMmOShm35kD3AU1+8rpyQFe8sfseA+50KQD6QWLvW6l6NYIOKFaQ==
X-Received: by 2002:a05:622a:3ce:b0:441:571a:25f9 with SMTP id d75a77b69052e-447cbef57f1mr42444321cf.14.1720135700454;
        Thu, 04 Jul 2024 16:28:20 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446514180d7sm64815391cf.35.2024.07.04.16.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 16:28:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E0BF6120006A;
	Thu,  4 Jul 2024 19:28:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 04 Jul 2024 19:28:18 -0400
X-ME-Sender: <xms:EjCHZkepf3mXaXTsFghaEhPtNdtCbCA3-NzfD58BlGNP0kb6UDta2Q>
    <xme:EjCHZmP52lQqeDjfw2VXk7CFCD4rUrxkydabQDmuSjV4Q-MwV6hf16MjhQRuj28pK
    QAaxDG1Ik__n8KpRA>
X-ME-Received: <xmr:EjCHZlh575U6mWXxIoGxUvWdgdW0o2cWpURSr6u_UaMhbrMgqROlYwAWM2iQdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:EjCHZp8m_2-JNbv46bGqRereyKwjVrtcndjs31Mpny1d6E4Qtmh0Qw>
    <xmx:EjCHZgsQLqVhRSAcatvHJ4B9DxaUDqBE_zIcpunlwcXifG6j9ZmJyQ>
    <xmx:EjCHZgFTEYzqv4pgcJ-w656xm_br40goRz7Am1AYa_8nwIQuRmCvFQ>
    <xmx:EjCHZvPOfAnRUdI7AuyXjmEDKuu2djgtR7qximdJgtOxLgpX02DnQg>
    <xmx:EjCHZlM8x7bh9dg99vTgn38PrVcwxkg2yKbh84cMTeQ7TRNflZnLAGZ2>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jul 2024 19:28:18 -0400 (EDT)
Date: Thu, 4 Jul 2024 16:27:13 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 15/20] rust: alloc: implement `collect` for `IntoIter`
Message-ID: <Zocv0RFghfk56NHE@boqun-archlinux>
References: <20240704170738.3621-1-dakr@redhat.com>
 <20240704170738.3621-16-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704170738.3621-16-dakr@redhat.com>

On Thu, Jul 04, 2024 at 07:06:43PM +0200, Danilo Krummrich wrote:
[...]
> @@ -658,6 +658,87 @@ impl<T, A> IntoIter<T, A>
>      fn as_raw_mut_slice(&mut self) -> *mut [T] {
>          ptr::slice_from_raw_parts_mut(self.ptr, self.len)
>      }
> +
> +    fn allocator(&self) -> &A {
> +        &self.alloc
> +    }
> +
> +    fn into_raw_parts(self) -> (*mut T, NonNull<T>, usize, usize, A) {
> +        let me = ManuallyDrop::new(self);
> +        let ptr = me.ptr;
> +        let buf = me.buf;
> +        let len = me.len;
> +        let cap = me.cap;
> +        let alloc = unsafe { ptr::read(me.allocator()) };
> +        (ptr, buf, len, cap, alloc)
> +    }
> +
[...]
> +    pub fn collect(self) -> Result<KVec<T, A>, AllocError> {
> +        let (mut ptr, buf, len, mut cap, alloc) = self.into_raw_parts();

We have leaked the `IntoIter` here,

> +        let has_advanced = ptr != buf.as_ptr();
> +
> +        if has_advanced {
> +            // SAFETY: Copy the contents we have advanced to at the beginning of the buffer.
> +            // `ptr` is guaranteed to be between `buf` and `buf.add(cap)` and `ptr.add(len)` is
> +            // guaranteed to be smaller than `buf.add(cap)`.
> +            unsafe { ptr::copy(ptr, buf.as_ptr(), len) };
> +            ptr = buf.as_ptr();
> +        }
> +
> +        // Do not allow for too much spare capacity.
> +        if len < cap / 2 {
> +            let layout = core::alloc::Layout::array::<T>(len).map_err(|_| AllocError)?;
> +            // SAFETY: `ptr` points to the start of the backing buffer, `cap` is the capacity of
> +            // the original `KVec` and `len` is guaranteed to be smaller than `cap`. Depending on
> +            // `alloc` this operation may shrink the buffer or leaves it as it is.
> +            ptr = unsafe {
> +                alloc.realloc(ptr.cast(), KVec::<T>::buffer_size(cap)?, layout, GFP_KERNEL)
> +            }?

and if `realloc` fails, we end up leaking memory, right? A simple fix
would be continuing if `realloc` fails. Maybe you could even make this
function returns `KVec<T,A>` instead of a `Result`.

Regards,
Boqun

> +            .as_ptr()
> +            .cast();
> +            cap = len;
> +        }
> +
> +        // SAFETY: If the iterator has been advanced, the advanced elements have been copied to
> +        // the beginning of the buffer and `len` has been adjusted accordingly. `ptr` is guaranteed
> +        // to point to the start of the backing buffer. `cap` is either the original capacity or,
> +        // after shrinking the buffer, equal to `len`. `alloc` is guaranteed to be unchanged since
> +        // `into_iter` has been called on the original `KVec`.
> +        Ok(unsafe { KVec::from_raw_parts_alloc(ptr, len, cap, alloc) })
> +    }
>  }
>  
>  impl<T, A> Iterator for IntoIter<T, A>
> -- 
> 2.45.2
> 


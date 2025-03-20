Return-Path: <linux-kernel+bounces-570466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C69A6B0AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D14019C25E9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4D21B422A;
	Thu, 20 Mar 2025 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="d6T5yEly"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7D1F4CAC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509324; cv=none; b=NO3CNDABHW2uEx01PgmsWLaBTsQU/CJgDjXGyakdECx+ibGdorLgu8zzh8JTsDKBOzD5UY4vtMIxd9Fiich9yyeDBG5moEHCNugSRtgSB0dCiMfpINRysYI3FOkMni24m6KMyIv/5tdWMJMGFoCRsRXOT2JickCqGZtOUEeII3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509324; c=relaxed/simple;
	bh=/9IupfoS+aiHJcuUOULQMXT2HMqYQt1igYXUTT8eIEo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=X7M6hDQbZAoGouE8Eavhuz8UvDo4gVQZJ5/qTxa84XkI+R5Q7e454NpADF3jDVLkwBvQEM4HRqE6ceOr+FqyJP/Fk0SBYHTnc1Sdq80ioCCPMXkNUYjzTPnlZihMSNEYTLl9hdYz03vq77utbXzqimByrCAN4o3aT3BJDohKekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=d6T5yEly; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742509321; x=1742768521;
	bh=TrJztFCk8Z9fLwx377hSlrUS+2GuthUOlCSMAdqQEjU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=d6T5yElyaFIeWZTPgB9GjHR5MGtP1o4kjzRyT/gEJcJGNaS4mgNt88Uc3PMoljR6r
	 6suzLqO2n92vFu0d3cY77he8yofRl/2VQpw6wF242f4Xzz/7SunZisJOO4033D+9xv
	 lxFfW3CMYhTAXEToQmRu/iTWqv13n5CxAFA+VQDrBdsFFBk8uRNwAZVRpQYgOlOC99
	 vkOobpj9kJ4t0Tt7kbasld0WLtOJRY3AV45kvrKnTkemJhlkpRUkGrJU4zZ8cHpmfr
	 5A/efeZOI4gm7EbxK0IAvDAxwkjfvatC6ZYVhIVf89ljYs+WZe3yyXEvKTpbSPqKdw
	 Iodqm5xbSCnXw==
Date: Thu, 20 Mar 2025 22:21:56 +0000
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] rust: alloc: add Vec::retain
Message-ID: <D8LFZZXODIR4.5XCGWBP93NNX@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: eb9a79e14a0a7ed328c405e7c699b82953c5a550
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 2:53 PM CET, Alice Ryhl wrote:
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index 303198509885f5e24b74da5a92382b518de3e1c0..00dabea8ea6c8a742a7fc9595=
4d8de58be124493 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -588,6 +588,20 @@ pub fn drain_all(&mut self) -> DrainAll<'_, T> {
>              elements: self.spare_capacity_mut()[..len].iter_mut(),
>          }
>      }
> +
> +    /// Removes all elements that don't match the provided closure.

Can you also add an example here? Otherwise the code looks good.

---
Cheers,
Benno

> +    pub fn retain(&mut self, mut f: impl FnMut(&mut T) -> bool) {
> +        let mut num_kept =3D 0;
> +        let mut next_to_check =3D 0;
> +        while let Some(to_check) =3D self.get_mut(next_to_check) {
> +            if f(to_check) {
> +                self.swap(num_kept, next_to_check);
> +                num_kept +=3D 1;
> +            }
> +            next_to_check +=3D 1;
> +        }
> +        self.truncate(num_kept);
> +    }
>  }
> =20
>  impl<T: Clone, A: Allocator> Vec<T, A> {




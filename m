Return-Path: <linux-kernel+bounces-275182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D9B948186
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75277B22FB2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB815ECF2;
	Mon,  5 Aug 2024 18:23:43 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BDE13DDA7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882222; cv=none; b=Iqbw3pw8UHPHoTevuHuKOZ3zs5X8eu7l9KZqxN771S/rujfCA7+Nm3ZkcEAqQz7ORJcRddF5RzgiwsnAFPqQK/uJo9XNa0TJZbcwZmC0alI9xJ1kgK0dkYZfE0FKe4bCtRJPCA88voC4p9KIYRtqUmvS6k1wJBDz3aRNHfozvVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882222; c=relaxed/simple;
	bh=KM4bcy09IdMoGGbGcB3cmLprTmMB7PZihB/JcmDQPb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brvNl5ajjdn03E8gUovkHjixLD1pl5X1F2VFr76CAmj+Pcd4jKfv+vPvzDKSr80tBStFNOmTxi2YwH5Kpo/03dvyMsyyoBs1HiRlCCElREOYr1fDqMufshhPiJBWfPJGMST7PtS5dHqv7DUlQUPr7gWWybkCtoCAXWNg8v7RbcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-70942ebcc29so6904610a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882220; x=1723487020;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KM4bcy09IdMoGGbGcB3cmLprTmMB7PZihB/JcmDQPb8=;
        b=Ts8xPLz+1IlDxMU5eApmrO00MlZtIJtenjWOMublcudV3aR5NgDfCsLSPj2eNm7V7+
         4RW+zpwzykn9By21qilebd07HD7ScRIl4GAY0HLqYBMs3xsM/MLbYOe+bC7ILWk+CJMg
         CmMxDJtjhK4NptuW9uqJ5XV5atp9kKqMeI5csjlA+Qfbo+Hz0WD2I9N0yMsoeURmIooS
         0+AJ5v5UcITOI5htUENEOgKl8kQssGWjYL8/xkmUdNccv3uVKGV0eg0z8tvMkNslweGK
         /7SPkTVWgRwUnhXpksI9141BW8y3hVfeZ3SAlZEmau5MzRBr6JAnHyOGxB/+cg3hBHjI
         HZNw==
X-Forwarded-Encrypted: i=1; AJvYcCVgw9dQgEgd9wvtnaEZN8j3vihxEpgESw1wJrFxZjBqMsEFL6XG9718ZXgXNv1Oo7FZQ7HqJ6bRjczR2ZmQ7F8600QElPFsfHlq4I9W
X-Gm-Message-State: AOJu0YwiUvCvyhz+AGPaI6lCjCMEY8cdkpNWWOOa7p14MgAEuIleW87s
	C8Owl1tiQcXOjtzaWkTFjUgEaoNR6/p07MNl0m2VbEboMICqPCIv
X-Google-Smtp-Source: AGHT+IEDbeZTRHeOHcvTxf3z1hxREkHtZqQg/065QXoctLdmf4wyfqo8WhxGYq+QvWpRINdeNXtrVQ==
X-Received: by 2002:a05:6830:3807:b0:709:5601:abea with SMTP id 46e09a7af769-709b32125e0mr18739735a34.10.1722882220404;
        Mon, 05 Aug 2024 11:23:40 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6adb2dsm31166661cf.18.2024.08.05.11.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:23:39 -0700 (PDT)
Date: Mon, 5 Aug 2024 13:23:37 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com
Subject: Re: [PATCH 3/6] sched_ext: Use update_curr_common() in
 update_curr_scx()
Message-ID: <20240805182337.GE42857@maniforge>
References: <20240804024047.100355-1-tj@kernel.org>
 <20240804024047.100355-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hlREn3PPZgvH73lr"
Content-Disposition: inline
In-Reply-To: <20240804024047.100355-4-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--hlREn3PPZgvH73lr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2024 at 04:40:10PM -1000, Tejun Heo wrote:
> update_curr_scx() is open coding runtime updates. Use update_curr_common()
> instead and avoid unnecessary deviations.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

Acked-by: David Vernet <void@manifault.com>

--hlREn3PPZgvH73lr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZrEYqQAKCRBZ5LhpZcTz
ZPMLAQCw8HA+oBhc8bPmjFrHbzUITO2uWxEPUsmEoCt+xTIkTQEAvQDNAQ1FDy5x
o8+1IB4xkEax4LXxafkSBt0xNYdlBwM=
=7ClL
-----END PGP SIGNATURE-----

--hlREn3PPZgvH73lr--


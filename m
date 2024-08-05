Return-Path: <linux-kernel+bounces-275116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0369480C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A5E1F23B19
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399E915F3F9;
	Mon,  5 Aug 2024 17:56:03 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007848CCD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880562; cv=none; b=sTeSRebfBUm1jnK4aPrLHy2ixz7tatqqZaRAyFsJjCB2RCJ+DloTtFlmxDyFo2BCEDihpJh9G9PJRNqIO6GmVvWjdg9HHT0bTwbKT0XacMQ6GIYgu1lUxqwfd8oYoQF8Pc+oeUm3qf7FPxSEVC13G2zZV/BoowSGmFp/4xR3Tyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880562; c=relaxed/simple;
	bh=NPwBovYJbFj4Iy+bcV2ZM2/J1bAoGVXS76LU0XYgs30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/oUyjqMbAvEJk83llH8DrqA6Zs0hsqyeuw3akCzweo9+8aE+XD+Z5dbqFz3MTagWDUzyXGpHXNysqGpB2F5qmNPcyBmQKzp77Wk+dhDt9YirqY8y9GP4zIRZf7jdi3E53iJOU/sUj6CB6JcGEj2NCyWiAbkkZLZqKolFa6X7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70938328a0aso5334442a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722880560; x=1723485360;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPwBovYJbFj4Iy+bcV2ZM2/J1bAoGVXS76LU0XYgs30=;
        b=K2YYC9yPDpshNMAv8lTSERmqHKdkMBLHDGX8NiM8sS+Fq+rnCWRF938RFAwVaxC53k
         +hpnEJlOnyWK1eL3KlaNrs/E1KPfzNTseqOV8NpM+eMvgpZu6oA6U6gRiCIUy90CXuG5
         KEyNWljHzH/E+9RTGUcqWzwmjdE1UY/A/48M/nRcvIH7Vq38zzMKpI9MQ6EH7zKbZU3B
         1O9b5uUbMjDhVX0Bku47H+gtBp+IF29qlob7zUHWBditVRkJuDtOUUpWVIB3cJH+Wdcy
         EyjVZH6Ns3yURWJahL5Et+m1+8IuV5EQ8VBy3KhVG7KKIxh/jZ/jMn/Tbi6XmfYj1j8x
         Dh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHZ1ethzgZiyNcPwu/LGckJnQAlLjBJ/Ai5pb9XRZYkvhDiEWx+tJDkBGV7t89UL1nqI+7VJDseIDA+yp2/emNUklQmi3JBe93ZB80
X-Gm-Message-State: AOJu0YyGarVHWjq4ZDlXjkDR2rGUAzIfJLlMUfNruuOzwoKIgavKaXpC
	odDUO4MGlgCTiN9J6P3/xm43o/rtwfK3it/ApuOkmnNE5lAHBzDq
X-Google-Smtp-Source: AGHT+IH3UqvriBq1vugHMKE8oWflSSjaLbE6UGfZsO4aDSQrLUhPhnJkfyXVouN/cBw+Owo4X7tOXw==
X-Received: by 2002:a05:6359:4c18:b0:1aa:a01a:23da with SMTP id e5c5f4694b2df-1af3babb0f2mr1580254455d.27.1722880559962;
        Mon, 05 Aug 2024 10:55:59 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c87d8afsm37696856d6.132.2024.08.05.10.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:55:59 -0700 (PDT)
Date: Mon, 5 Aug 2024 12:55:56 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com
Subject: Re: [PATCH 1/6] sched_ext: Simplify scx_can_stop_tick() invocation
 in sched_can_stop_tick()
Message-ID: <20240805175556.GC42857@maniforge>
References: <20240804024047.100355-1-tj@kernel.org>
 <20240804024047.100355-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PCjctS0U5bNHBr3r"
Content-Disposition: inline
In-Reply-To: <20240804024047.100355-2-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--PCjctS0U5bNHBr3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2024 at 04:40:08PM -1000, Tejun Heo wrote:
> The way sched_can_stop_tick() used scx_can_stop_tick() was rather confusi=
ng
> and the behavior wasn't ideal when SCX is enabled in partial mode. Simpli=
fy
> it so that:
>=20
> - scx_can_stop_tick() can say no if scx_enabled().
>=20
> - CFS tests rq->cfs.nr_running > 1 instead of rq->nr_running.
>=20
> This is easier to follow and leads to the correct answer whether SCX is
> disabled, enabled in partial mode or all tasks are switched to SCX.
>=20
> Peter, note that this is a bit different from your suggestion where
> sched_can_stop_tick() unconditionally returns scx_can_stop_tick() iff
> scx_switched_all(). The problem is that in partial mode, tick can be stop=
ped
> when there is only one SCX task even if the BPF scheduler didn't ask and
> isn't ready for it.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

Acked-by: David Vernet <void@manifault.com>

--PCjctS0U5bNHBr3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZrESLAAKCRBZ5LhpZcTz
ZO14APoCNbGxwPLqGikuRpZo9IcTs0mrd7FO9kyqrpv2pmMKIQEAiILX3iElnBnb
EY1Src9hGfDUXm4hOVWj3tjMApJk1Aw=
=wLkE
-----END PGP SIGNATURE-----

--PCjctS0U5bNHBr3r--


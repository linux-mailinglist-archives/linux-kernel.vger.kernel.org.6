Return-Path: <linux-kernel+bounces-279988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDA994C434
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C074287399
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69243146A7A;
	Thu,  8 Aug 2024 18:21:29 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946475579F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141289; cv=none; b=CZFoqPgL85ZpwkJddf/pIH07p+UvXSoXI0C0kZbVODHNg4UZy/tHYAeqZltNY7VKYxB2JLysdkT0pV/Ny2YUjVRPSbdfiM6ua7HMh0y0D5v8EOUCK9vr31E1sLGa3Xrp6N5dKvXOM9AaKJugTJOqxSLf8J6eMeMNvjVhWA6c2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141289; c=relaxed/simple;
	bh=+uh1F1CviEfQWGmPnfhIEz56etypldBTPBg2ONmnrdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIuDfNhmYMKl+hU2PbPlXIbOCcmOhkaqvkNsFlaLzRs/Djv/mQdLaWXgOROSkwWGaPEGywo8gTBbk/pMzowvXNbxnmj1nzVJro+80IrxbzrOBbqX3/5YTBrVA2lPrqzbHwh529itgdAWfO2QtsCyVkxeudkDFjSFS46xCeesa94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-447d6edc6b1so7112091cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141285; x=1723746085;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uh1F1CviEfQWGmPnfhIEz56etypldBTPBg2ONmnrdE=;
        b=gnLSE/htax0zplX1wjW9zRwmMSfEAa7daOODbwUAOgVcPanN1dmDIg/MVlVPceTDsS
         NMeLSsZEiLpTR+mHkLg9JQZSbaIkqsI+p1lOT8ISfUL2V9xD7dcV6IVZlIZ+ul994/ni
         ydst9KGQCuEbpQVgbT4P4SgTTnhPFkVklY7Pbcna9A1VqvaXZoripoiEHvFKVwgoEBlV
         cxyqzvXM8c7cqedDSoVL/wybv7PTWqBqFuoP3WI2V7QyqJRuw3eE7PF20kDbnZK9O7TT
         miGsMoRK9sqf9fhexQkGhHL+iTKI4fPqMEykKzzyWO5aYqsaSfcUVT0mTlrbTHLkKv1X
         +vAg==
X-Gm-Message-State: AOJu0YwvGJ2Miv4HaPXaBr9y/xjyG7YRb5QUNaLoFrRlCj+pR/6gQIxr
	q7k3Obq2w6sEJO7khwBwbBWdpVjLUO1oa3IuEWfEf0SF0dct3mkxj2pJkQ==
X-Google-Smtp-Source: AGHT+IH1Ddcqdy8A0blZ6b8ZqqU8dvGaWkEdNpu1tyTc/Qc6nymlcRRI7pBQF2dUZkpZl6WT/uWMfA==
X-Received: by 2002:a05:622a:424e:b0:447:f953:7b63 with SMTP id d75a77b69052e-451d42e3083mr26734391cf.53.1723141285302;
        Thu, 08 Aug 2024 11:21:25 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c8718cd5sm15116921cf.38.2024.08.08.11.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 11:21:24 -0700 (PDT)
Date: Thu, 8 Aug 2024 13:21:22 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Fix unsafe list iteration
 in process_ddsp_deferred_locals()
Message-ID: <20240808182122.GF6223@maniforge>
References: <ZrPWYqSbif3eTME4@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zkpzZDq+iFn+VVwl"
Content-Disposition: inline
In-Reply-To: <ZrPWYqSbif3eTME4@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--zkpzZDq+iFn+VVwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 10:17:38AM -1000, Tejun Heo wrote:
> process_ddsp_deferred_locals() executes deferred direct dispatches to the
> local DSQs of remote CPUs. It iterates the tasks on
> rq->scx.ddsp_deferred_locals list, removing and calling
> dispatch_to_local_dsq() on each. However, the list is protected by the rq
> lock that can be dropped by dispatch_to_local_dsq() temporarily, so the l=
ist
> can be modified during the iteration, which can lead to oopses and other
> failures.
>=20
> Fix it by popping from the head of the list instead of iterating the list.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 5b26f7b920f7 ("sched_ext: Allow SCX_DSQ_LOCAL_ON for direct dispat=
ches")

Acked-by: David Vernet <void@manifault.com>

--zkpzZDq+iFn+VVwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZrUMogAKCRBZ5LhpZcTz
ZGS6AP9IbYEgsRTO99r9DQDOcbUZi9aKnmHtXU2+Js6QVV3mfAD+IBsn3hfHhRON
jqKXeJDhITMvK5gZ997KLfdEg6oXdgo=
=jAwW
-----END PGP SIGNATURE-----

--zkpzZDq+iFn+VVwl--


Return-Path: <linux-kernel+bounces-279957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B284D94C3D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693701F217CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEDB190661;
	Thu,  8 Aug 2024 17:39:44 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E313D8A3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138784; cv=none; b=MjLs+VUE6YrjyTYVy8XOvyUqC13RIUu39Z4TOKdXLwYZDz9LwlFyunM/VyJV+/b1UkK4/4iL/mJO9Das6VqIcMNFrFYJXTXmdprKX8UCUNUKPm5Z53flEoszTEC5RuqrTNkH6HXLRlF5X6gq61y5ZAXVnW+ymGnlfary+WYBb5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138784; c=relaxed/simple;
	bh=a7epOdiUlRm0EsIsv62mS5S/tA2LlKN2giVuPM5+I0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/9sq9mhQY06QlaMaAvYA8iVcI4Dy2qX5fFJbQE7zNqB8nrJUQstLYSb7P6tOBzlOPuwTx7Yx6QMlw24zqPYoLB/SevDoecTMgqSjt95j6THy/tsfw6D+eaL3IG9PIFS37Nhr+/zRxgEDFnfAA397IkWDHXuqeIjtBIQuDhLL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4519383592aso7466351cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138781; x=1723743581;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7epOdiUlRm0EsIsv62mS5S/tA2LlKN2giVuPM5+I0w=;
        b=v+C4sFGp1F65y/oHaKE+CJ8PtytNPvjdDzCnSrhFkkDp0Qa3drcpDZ5GCDby8aGD9D
         fmap4pf4ejjhZsBTsChlBZ6ZrcvON8xTW/LN0JM7w46fJNfuQyD+getAG45UbXZaUMLV
         oNPIpqKiElYwXw9+w0n8dROJX9Ek+4n8SBZAG53zmMR+G4KIFZbBQleBlqnaQmKyGbXf
         rboTVdTzyVuPAK+v7SzP8Ov4yBGRvu66ioRy6Wh+GLE2Wt7TJ8xKfj5eXa+ja2zgxdj5
         PQKL35m88Dx5RYrntAgd4/8s99XNAeat1shWqnpUHlMi5ganPjRZup5RDeBk7/BuV0FK
         pxwg==
X-Gm-Message-State: AOJu0Yzh2QL8Fz3V6aTDSYwMsdO6yoX1nq+2Bga0qny0BObS6gUbtD02
	es0RxOBOiYg/3SYCWTzV47Ce87aPNy6WBRxsTvIhbCZKa+22gyEb
X-Google-Smtp-Source: AGHT+IFfYHJJQ9mo0FzAPR0NRlK2vArzJUBEqLZQRQwSfvOWko5mgToJuAIQHXXK0Ww8dcIGJ73HQg==
X-Received: by 2002:a05:622a:1b19:b0:447:f559:eb96 with SMTP id d75a77b69052e-451d42012bfmr30747501cf.11.1723138781329;
        Thu, 08 Aug 2024 10:39:41 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87d934asm14798941cf.65.2024.08.08.10.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:39:40 -0700 (PDT)
Date: Thu, 8 Aug 2024 12:39:38 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Make scx_rq_online() also
 test cpu_active() in addition to SCX_RQ_ONLINE
Message-ID: <20240808173938.GD6223@maniforge>
References: <ZrPxkt57GdP6ILlA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5SQI4IasKi52TMhm"
Content-Disposition: inline
In-Reply-To: <ZrPxkt57GdP6ILlA@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--5SQI4IasKi52TMhm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 12:13:38PM -1000, Tejun Heo wrote:
> scx_rq_online() currently only tests SCX_RQ_ONLINE. This isn't fully corr=
ect
> - e.g. consume_dispatch_q() uses task_run_on_remote_rq() which tests
> scx_rq_online() to see whether the current rq can run the task, and, if s=
o,
> calls consume_remote_task() to migrate the task to @rq. While the test
> itself was done while locking @rq, @rq can be temporarily unlocked by
> consume_remote_task() and nothing prevents SCX_RQ_ONLINE from going offli=
ne
> before the migration takes place.
>=20
> To address the issue, add cpu_active() test to scx_rq_online(). There is a
> synchronize_rcu() between cpu_active() being cleared and the rq going
> offline, so if an on-going scheduling operation sees cpu_active(), the
> associated rq is guaranteed to not go offline until the scheduling operat=
ion
> is complete.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 60c27fb59f6c ("sched_ext: Implement sched_ext_ops.cpu_online/offli=
ne()")

Acked-by: David Vernet <void@manifault.com>

--5SQI4IasKi52TMhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZrUC2gAKCRBZ5LhpZcTz
ZP0GAPwPm/2HFOtEQbrNt7dzeyK4EJqNZxEZFttp8gdsLo+oowEA1uPpefGe2OzL
jIzEig+xqfKF4GpYItThp9Jf9hdfPgM=
=ZzCw
-----END PGP SIGNATURE-----

--5SQI4IasKi52TMhm--


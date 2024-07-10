Return-Path: <linux-kernel+bounces-248126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189C92D8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35AFC1F25A58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C6F195FFA;
	Wed, 10 Jul 2024 18:53:38 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ECB194C96
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637617; cv=none; b=RHNi+cDRVzDON7QOJbJCkZPf9B7XprpVfpexFqoKHr5dC7gaymmlQOeubw007+qj7pTU8jczyxXFf5wjsweQHvIxnrwd6wYzvU65kvQ2iycDTAbPLdFosDbIvJ6ewk5zyF47pck+PYYk1cmQmfcXLTVLobvtvH3+pnk3+fjR4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637617; c=relaxed/simple;
	bh=BLXoXzQw51i/N2EQOZRcO0aEuYCOpkCDyt7bGCOi+Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miogq2ei2kbAl4cAtdzJYojB9+Jtrq55P6KcvpUiKBwAEnBvf+7XnsOr8M8YbBGXhtMUvDKFXdcH1Ma8YAf5O9FYAulrNMKKi+mHGcHB5BHOOywP3i6tK+J+yCKfEmyIJMY/hK0HGb0FioPKsNuUi2O7Z+7X486t9U2eY4bRLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d9dfc7c5f6so71753b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720637615; x=1721242415;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLXoXzQw51i/N2EQOZRcO0aEuYCOpkCDyt7bGCOi+Hk=;
        b=Qngy6zlK/+iP9TG0evkeqQFrg6tddacre/4Z613r2uv6DA3n4Z2WElj65wGiA9Lhli
         hWvPjXObO4o5wxTVp/l0dRwxsggCYrf5ORssPCYqRGLXRgUYh8w50fl2BaYOu0TrqAIR
         lf4D5egd+EEtYhwARfdK7i/1/iBjH5YafEXHRwqvB0XiUkNBaSn/uzrqLvUHEEnQElVU
         OrcuGp4CAaQFOcJKegxotbdczjNTrOBTB+Ir1LPF/lRfE+juROSdpmg94WGr/E6GUwfp
         uXO2uUhzdsk61Kc7hOAVhzVmhc9eSDQz/k6l8Cd99XbujK9xMExYVoQ6yXz8rl5udJ2H
         mTrw==
X-Gm-Message-State: AOJu0Yz8b+VMYUUvhKhGxkWVwLY8qTRhA26dwdNVjHxJlBlLv5lm6dU2
	dTVmJeFItrZXpYC73tgxxDJPvZ+t2U7uVRxt+4IKtCzpuscbsGLR
X-Google-Smtp-Source: AGHT+IFNoFkuf/REng6OoasXkOax62lWFz8qCeqt/xvJffBw4+mDzhcF2x97xzQWr+QRxQWP0ZiQtg==
X-Received: by 2002:a05:6808:1a0d:b0:3d5:64d6:9f1e with SMTP id 5614622812f47-3d93c0aad4amr6946758b6e.36.1720637615419;
        Wed, 10 Jul 2024 11:53:35 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19016cc3sm218826785a.50.2024.07.10.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:53:34 -0700 (PDT)
Date: Wed, 10 Jul 2024 13:53:32 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, righi.andrea@gmail.com
Subject: Re: [PATCH 2/6] sched_ext: Open-code task_linked_on_dsq()
Message-ID: <20240710185332.GD317151@maniforge>
References: <20240709212137.1199269-1-tj@kernel.org>
 <20240709212137.1199269-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SqJAuaDiPDe3+GZF"
Content-Disposition: inline
In-Reply-To: <20240709212137.1199269-3-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--SqJAuaDiPDe3+GZF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 11:21:08AM -1000, Tejun Heo wrote:
> task_linked_on_dsq() exists as a helper becauase it used to test both the
> rbtree and list nodes. It now only tests the list node and the list node
> will soon be used for something else too. The helper doesn't improve
> anything materially and the naming will become confusing. Open-code the l=
ist
> node testing and remove task_linked_on_dsq()
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>

Acked-by: David Vernet <void@manifault.com>

--SqJAuaDiPDe3+GZF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZo7YrAAKCRBZ5LhpZcTz
ZG90AQCvc33EHjHfaOldV3a0KEs2F0Rg/OhKnlMW1oquWq7mLwD/csQwbMj/0ozq
qKbzNRDMQxd3Z3RoXtb8ccMiJTmn2Qs=
=XKTg
-----END PGP SIGNATURE-----

--SqJAuaDiPDe3+GZF--


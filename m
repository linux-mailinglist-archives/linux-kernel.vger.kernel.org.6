Return-Path: <linux-kernel+bounces-513074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02947A34154
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9E93AB827
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D0726EFD4;
	Thu, 13 Feb 2025 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PgSiSUqW"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3640226EA31
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455196; cv=none; b=WPTl/BSV1qRlMUwt8BaaCeHxnnFl9nauGbcRZaKiqi5mQ33rz+ztWlFfA1RWYBSkJ1yBccI9mSDvEisNVBV3SP+6JiRlRdjbxTeFDNsXKMgVYcq1YGXzmv6SKozxi8M1KZn9F8ZJvUqBhrVpDP0yuwJ6K1xMKVX63oURp7R/OAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455196; c=relaxed/simple;
	bh=0M7uRvDMVPcVxrva7x711BzlxUpcCGcZM0xehPkPIHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efJo02XbZ3sQUH9tTCyZc/fL2Cw3Q3Te2GnRaU+KXCNlqD3DUOXNhQVnY25Mwqk7emUXGYZvR93+aYmI/cUvZob652XjRhqiAwp9SmOZq192tcmPAVYE6hZMJH+FzUm2l8mbomZW7ai+ZBztoiZ/t6FNk4dK2Ovy82OxB9H2NCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PgSiSUqW; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB6BC442EA;
	Thu, 13 Feb 2025 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739455191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZQZsiaxrcI9Vx1C2CdJQT1aJzmYPDK4yU1imNL3BwY=;
	b=PgSiSUqWb3z2PZOTzptk54eeDfZKqS0Yagm07xeLkVnLzhM80SSA7GE116kGyV/WphcuO5
	MTizD6xeckyz94JmESdf/cO1AzaABnjpZMR63VL+H0nUfxc/tsY0CghYuPpgngUBiPcHqi
	v+Nq9ZbqFg0KEHjh2/eHZlB0jID5VDJ3jyvuxq9BJgyzZnoU3falu9ySGNwT3OBzCf4i9m
	joavIdeDyLeLG1DS+nyW+6Dx3RDTkNWizjGoha074PhVHVXKQNuJrIQ5EE5eFgn5sIiChv
	QLGQfZZDdvCNBB11m4tXLXA1Ng2rgOKGXBIywAo0Fd4qFkn4fhR/poOJIJV/5Q==
Date: Thu, 13 Feb 2025 14:59:49 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Arthur Grillo <arthurgrillo@riseup.net>
Subject: Re: [PATCH v2 04/15] drm/vkms: Add KUnit test scaffolding
Message-ID: <Z6361TEh9vNrBu7j@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Arthur Grillo <arthurgrillo@riseup.net>
References: <20250211110912.15409-1-jose.exposito89@gmail.com>
 <20250211110912.15409-5-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211110912.15409-5-jose.exposito89@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfejveetkedvleetudeuudegfeejheeujeefkefgtdeugfetfeeutdevieekvdeknecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrgdrshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrs
 hhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com

On 11/02/25 - 12:09, José Expósito wrote:
> Add the required boilerplate to start creating KUnit test.
> 
> To run the tests:
> 
>     $ ./tools/testing/kunit/kunit.py run \
>       --kunitconfig=drivers/gpu/drm/vkms/tests
> 
> Co-developed-by: Arthur Grillo <arthurgrillo@riseup.net>
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/gpu/drm/vkms/Kconfig                  | 15 +++++++++++++++
>  drivers/gpu/drm/vkms/Makefile                 |  1 +
>  drivers/gpu/drm/vkms/tests/.kunitconfig       |  4 ++++
>  drivers/gpu/drm/vkms/tests/Makefile           |  3 +++
>  drivers/gpu/drm/vkms/tests/vkms_config_test.c | 19 +++++++++++++++++++
>  5 files changed, 42 insertions(+)
>  create mode 100644 drivers/gpu/drm/vkms/tests/.kunitconfig
>  create mode 100644 drivers/gpu/drm/vkms/tests/Makefile
>  create mode 100644 drivers/gpu/drm/vkms/tests/vkms_config_test.c
> 
> diff --git a/drivers/gpu/drm/vkms/Kconfig b/drivers/gpu/drm/vkms/Kconfig
> index 9def079f685b..d4665e913de7 100644
> --- a/drivers/gpu/drm/vkms/Kconfig
> +++ b/drivers/gpu/drm/vkms/Kconfig
> @@ -14,3 +14,18 @@ config DRM_VKMS
>  	  a VKMS.
>  
>  	  If M is selected the module will be called vkms.
> +
> +config DRM_VKMS_KUNIT_TESTS
> +	tristate "KUnit tests for VKMS." if !KUNIT_ALL_TESTS

If there is a v3, can you remove the dot?

With or without this:

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

Thanks,
Louis Chauvet


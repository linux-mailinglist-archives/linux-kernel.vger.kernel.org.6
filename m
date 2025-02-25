Return-Path: <linux-kernel+bounces-531141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6148A43CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6883B4FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6C1267B1B;
	Tue, 25 Feb 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ViXF4NWm"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E1267708
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481324; cv=none; b=scgwfWCk2XMPQ9uiJ/i2nNvdYTw87PLrspADQ4nBYxFZxayN/AdB/XToRsJzSeHQxYewX11bsSYxrCZYrHxBLVWL+LSBz/PQeUnZwW0Lmvr7kdHDgaujcqxi0NMiYL2yVLI0BybWKwNlM+3w2L5DomLDn7TtTRRjg8uxG9g+wQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481324; c=relaxed/simple;
	bh=lOCLwQq7ukQSrEB/pSXv4j0DSImvoHSDCFDQM43g6VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL+7TlgutyZ9QrkNop0Tbbj/Pbb/LnnUt1erKitniOHP7T5oPNhW2CGZhlE9MEbPCUDQIf3zi+eyDFh14zvsfnPJtM/JHF8404kHa3OhRRlzAOo1/iqJsrShjc58A8Y0hVlfZ65dzcP3L/79lOwAK45jEhkuYxdEmKK+2faO1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ViXF4NWm; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21440204DB;
	Tue, 25 Feb 2025 11:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740481321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lis+lHVZ3LLTV+1D6rmDMk5TRuBmXQzInksWAQwV+4=;
	b=ViXF4NWmC07u1p3ZztSnmxYMOttRItA0DLIzLkSnNMnG18rWO6ZlaEVOjZ138jwSXQEHUF
	9BLboaKKVuJTkP8tYiiwTkDkUBD/Qzy25LMQW7dEUiWQE+bX+4sEqiJQqNKqssVVxRSaOg
	JG0n2oQcOmGlXiKdjZWGxNBQA5za2tsz8SdrJuGIMZqUezq/h69cZRyWG9d+lGNNTg76G3
	tn9NZrEMQ/weEvTk1CzCc2h+/fw9SWIpvcMWEOEjOqeImQuRDtr2dYhp3DpX3FHjlLgxMr
	nDUzLkesyvza2p1wufDMoMcz6ZJW5yyPeR/pZzakEQSjXkBL6tsXIKMf/qM2xw==
Date: Tue, 25 Feb 2025 12:01:58 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] drm/vkms: Add configfs support
Message-ID: <Z72jJtFCMypHpW_K@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218170808.9507-1-jose.exposito89@gmail.com>
X-GND-State: spam:low
X-GND-Score: 200
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmsghothdqtfegvdefqdegieculdeftddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepnfhouhhishcuvehhrghuvhgvthcuoehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiffeijeehfeeiffetffffgfelgfelheffiefgvefhfefhgfffgfelieeufffgtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhfrhgvvgguvghskhhtohhprdhorhhgnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhff
 ihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrgdrshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com

On 18/02/25 - 18:07, José Expósito wrote:
> Hi everyone,
> 
> This series, to be applied on top of [1], allow to configure one or more VKMS
> instances without having to reload the driver using configfs.
> 
> The series is structured in 3 blocks:
> 
>   - Patches 1..11: Basic device configuration. For simplicity, I kept the
>     available options as minimal as possible.

Thanks for this series, it is really nice!

I did some review, that can be sumarized in two point:
- Do we want to use scoped_guard?
- -EPERM, -EINVAL or -EBUSY when attempting to do something while the
  device is enabled
 
>   - Patches 12, 13 and 14: Allow to hot-plug and unplug connectors. This is not
>     part of the minimal set of options, but I included in this series so it can
>     be used as a template/example of how new configurations can be added.
> 
>   - Patches 15 and 16: New option to skip the default device creation and to-do
>     cleanup.

For the next iteration, can you move those patch before 12, 13, 14, so
1..11 could be merged before 12..14 (I need to think about the connector 
API to check if it will works with dynamic connector)?
 
> The process of configuring a VKMS device is documented in "vkms.rst".

This is a really good documentation!

> Finally, the code is thoroughly tested by a collection of IGT tests [2].

I quickly looked on them, it seems nice! Thank you for this huge
improvment!

Louis Chauvet

> Best wishes,
> José Expósito
> 
> [1] https://lore.kernel.org/all/20250218101214.5790-1-jose.exposito89@gmail.com/
> [2] It is not in patchwork yet, but it'll appear here eventually:
>     https://patchwork.freedesktop.org/project/igt/patches/?submitter=19782&state=*&q=&archive=both&delegate=
> 
> José Expósito (16):
>   drm/vkms: Expose device creation and destruction
>   drm/vkms: Add and remove VKMS instances via configfs
>   drm/vkms: Allow to configure multiple planes via configfs
>   drm/vkms: Allow to configure the plane type via configfs
>   drm/vkms: Allow to configure multiple CRTCs via configfs
>   drm/vkms: Allow to configure CRTC writeback support via configfs
>   drm/vkms: Allow to attach planes and CRTCs via configfs
>   drm/vkms: Allow to configure multiple encoders via configfs
>   drm/vkms: Allow to attach encoders and CRTCs via configfs
>   drm/vkms: Allow to configure multiple connectors via configfs
>   drm/vkms: Allow to attach connectors and encoders via configfs
>   drm/vkms: Allow to configure connector status
>   drm/vkms: Allow to update the connector status
>   drm/vkms: Allow to configure connector status via configfs
>   drm/vkms: Allow to configure the default device creation
>   drm/vkms: Remove completed task from the TODO list
> 
>  Documentation/gpu/vkms.rst                    |  98 +-
>  drivers/gpu/drm/vkms/Kconfig                  |   1 +
>  drivers/gpu/drm/vkms/Makefile                 |   3 +-
>  drivers/gpu/drm/vkms/tests/vkms_config_test.c |  24 +
>  drivers/gpu/drm/vkms/vkms_config.c            |   8 +-
>  drivers/gpu/drm/vkms/vkms_config.h            |  26 +
>  drivers/gpu/drm/vkms/vkms_configfs.c          | 918 ++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_configfs.h          |   8 +
>  drivers/gpu/drm/vkms/vkms_connector.c         |  26 +-
>  drivers/gpu/drm/vkms/vkms_connector.h         |  18 +-
>  drivers/gpu/drm/vkms/vkms_drv.c               |  18 +-
>  drivers/gpu/drm/vkms/vkms_drv.h               |   4 +
>  drivers/gpu/drm/vkms/vkms_output.c            |   2 +-
>  13 files changed, 1138 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c
>  create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.h
> 
> 
> base-commit: 9b6c03cb96b9e19bce2c2764d2c6dd4ccbd06c5d
> prerequisite-patch-id: 1bff7bbc4ef0e29266265ac3dc009011c046f745
> prerequisite-patch-id: 74a284d40a426a0038a7054068192238f7658187
> prerequisite-patch-id: c3e34e88ad6a0acf7d9ded0cdb4745a87cf6fd82
> prerequisite-patch-id: 9cd0dfaf8e21a811edbe5a2da7185b6f9055d42d
> prerequisite-patch-id: f50c41578b639370a5d610af6f25c2077321a886
> prerequisite-patch-id: 5a7219a51e42de002b8dbf94ec8af96320043489
> prerequisite-patch-id: 67ea5d4e21b4ce4acbd6fc3ce83017f55811c49b
> prerequisite-patch-id: 37a7fab113a32581f053c09f45efb137afd75a1b
> prerequisite-patch-id: 475bcdc6267f4b02fb1bb2379145529c33684e4f
> prerequisite-patch-id: d3114f0b3da3d8b5ad64692df761f1cf42fbdf12
> prerequisite-patch-id: d1d9280fb056130df2050a09b7ea7e7ddde007c5
> prerequisite-patch-id: 2c370f3de6d227fa8881212207978cce7bbb18ba
> prerequisite-patch-id: 938b8fe5437e5f7bc22bffc55ae249a27d399d66
> prerequisite-patch-id: ab0a510994fbe9985dc46a3d35e6d0574ddbb633
> -- 
> 2.48.1
> 


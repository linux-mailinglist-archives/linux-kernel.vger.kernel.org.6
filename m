Return-Path: <linux-kernel+bounces-513069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 940AFA34148
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FF23ACACA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB13C266D63;
	Thu, 13 Feb 2025 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yre9GBjE"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE76F2659E3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455172; cv=none; b=qyfFcR8oVVX50IiFZ57oefyDAZZxyn2VoAOaKE2VbvGaaYd6YSWn1fE6SttjWGl4IxU4vND2mL+QAMjaF42NTxPU5d2BM85B5xGYjuq+Q0M2Ez7xgiQ3ETkRvo6afqy2ySyfzFv6FqBpw092DGQxXT/IslqzrJKgllY/T+93xg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455172; c=relaxed/simple;
	bh=B3EVhb2sChLxbFYlS9SfpyN6hPxRFL79xQTd9P5shaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc6+2QFvo4857d1Q4J1gYrwu3NvB+Tgx+qnaenq7hw6i0mXzW0DB/NPNcelC/YlPyaB7Nv5mXiwjBQ4Pd3moKwbBNNtC89KnyMmIuvrA0LUTkg+P9/A6KCxIHJAH42sWj8RrD6q5lWXgONr+Hk8FQq3jZpZYu1pUIztDrfuiRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yre9GBjE; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72AB7441B9;
	Thu, 13 Feb 2025 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739455167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5E1tR8J1DQ0Vgiyo1BG2hPdnaggt1HGYG2HpklA7oA=;
	b=Yre9GBjEqyQ/ADG6hCpoNTq1l2zvEL5hZ3M0WfliyYmSmsuFzwwntxz8pd7+N0IQveqnrS
	M0XNPXChizrLnUJHcWVqAp9lozTTYbMfTMJEM0qqOCTZ7VFgcWQgNgkaKmNDbUsdXLqxM6
	kSKn6wIpYFU5wwsU3CKxMQezivc+neqH6CvHuiniJQeMwAv+1nAuLyJ5MpLclymZlKOweP
	2VB4tQ3AuynwpGXxx84HxoFrujDyb+mEndGICt2KzNXwlaBJflJkSG3xPs8NP4n/4qD323
	7Z9VekoUMUO8KyutrhK+wMZx6txIFV+tHLdHl2qEY1yFT5Q3yZA0j77sbn1Vmg==
Date: Thu, 13 Feb 2025 14:59:25 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/15] drm/vkms: Extract vkms_config header
Message-ID: <Z636vaJLmJ9RGI6L@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250211110912.15409-1-jose.exposito89@gmail.com>
 <20250211110912.15409-6-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211110912.15409-6-jose.exposito89@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfejveetkedvleetudeuudegfeejheeujeefkefgtdeugfetfeeutdevieekvdeknecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrgdrshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrs
 hhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com

On 11/02/25 - 12:09, José Expósito wrote:
> Creating a new vkms_config structure will be more complex once we
> start adding more options.
> 
> Extract the vkms_config structure to its own header and source files
> and add functions to create and delete a vkms_config and to initialize
> debugfs.
> 
> Refactor, no functional changes.
> 
> Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

This does not build in module, can you add this in the next version?

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 152b2ecd6aef..42caa421876e 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -4,6 +4,7 @@

 #include <drm/drm_print.h>
 #include <drm/drm_debugfs.h>
+#include <kunit/visibility.h>

 #include "vkms_config.h"

@@ -17,11 +18,13 @@ struct vkms_config *vkms_config_create(void)

        return config;
 }
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_create);

 void vkms_config_destroy(struct vkms_config *config)
 {
        kfree(config);
 }
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy);

 static int vkms_config_show(struct seq_file *m, void *data)
 {

With this:

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>


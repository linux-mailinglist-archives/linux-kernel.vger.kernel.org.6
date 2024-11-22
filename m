Return-Path: <linux-kernel+bounces-418458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A979D61D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55584160E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885F81DF732;
	Fri, 22 Nov 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UnIVGG6P"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35831DF26F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292120; cv=none; b=FQTH2lKiB0w6+6iIpU3r9YnBNYztWm30Kj9Ch3a7JAayPlqOwERwrp3HQAPn+J1Rz7q/L+rh0tAcVPzNocmnDnmiLkZzAhG/1u9LK01QZitrD9jgdNKeSeigTl2ZAA+vCw0u1jGZQoRgdwxGU/NvqZafEHdFg+dU12BJ59O8FCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292120; c=relaxed/simple;
	bh=axL606VOP+Vzkxig7OQTFfHk5EC8HgjRmS6iK/9rLyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RuGyqUxFCKqe8J5nAbuuF9ZPyw0UFYWat2mVRuwW86/Fp6JbDnGRUBAlgv8ru3bN1dEsI/qUDMzcWh+RM0x8jxtHRDU7DKUPdQChTRniXdJvC6QhCUcv/jC2d5c4Tf40yiBHLetXujcROWyMRGMDksNsQQRCSvNcABu2dg4abKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UnIVGG6P; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57C7C1C0005;
	Fri, 22 Nov 2024 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ROA9s97zr/TnBShjvPt9n/VC1Dc0gzXiBJZ5MkzKUk=;
	b=UnIVGG6PtfNfoD2S85gfD15bbQddp5DcxMxLSjc+jo42ZoF7rDgDZZ+UKCJwBBeIO5qa0b
	cp9SKt+S2HCeJOmhqtpQvA3a+JsaFDwAgY+x/LNZ0pRHfJ358ouzEoNOD1H/Yn20iibCee
	SxjjGrj6UTNygOaSjJhngKOlD5EUfld3MqdFkD239bUz1+IXfHKRlcLM2uU4EkqPGGA42V
	QrtkPRLdWm6kDosZ9ejVkocccsgkneGUnB54QgSCeHpu/dgPZqAgXOuNxS7ZecSZRdn7j6
	Gk3EJLMrGxB5sNRdKk803tKprG9uhwF27L91Hv7vo8TFKgc6VRtGB/VJfHuusA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:15:04 +0100
Subject: [PATCH v14 4/7] drm: Export symbols to use in tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-yuv-v14-4-e66d83d28d0c@bootlin.com>
References: <20241122-yuv-v14-0-e66d83d28d0c@bootlin.com>
In-Reply-To: <20241122-yuv-v14-0-e66d83d28d0c@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=axL606VOP+Vzkxig7OQTFfHk5EC8HgjRmS6iK/9rLyk=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQK4HXt7kZyL9h/sZ3lKLwtcJhjG6CeuXVv49x
 fiQQp9OE0WJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CuBwAKCRAgrS7GWxAs
 4p3OD/40fJ6Kxjor7dbrBzKuRdnky8GURp/WOHla6m/iz7pHGwbKMKOUqaXODZk3BvtItDPYsOT
 D8/vJlZvdjQ1zEs215Hp4fWh3aPYUgU+Xdot3NQMQ6asW7vioyV50efOOO/5z+20UQ+OScGQm7/
 cLNnHV9cbOAWlPZWXSU86o4NeiqakGcUuqqMEOXUKakD861zE1R3WN75yun8qX6T9Z8QQAoqYz4
 O1nwBqSjIBtsIeF4IdnRG1zaioa39wpVlKyO6Cv0HSfKNCZvgIholyk+ec61JA1TejQh+9OQ0Aa
 3i9GhQ0ALkXSKcjS3TOqVnCuWt1lv5moFQsqZpEjWWXkE5yq/lSF9Rswz7/tW7sAjdAa6FhAQ5W
 92BbA/WBdF+u4PRsqM/hg5svwl4/aO4puotlM1ajtnZEijvnn5qxhQ/9aXzA5lu8OiZ3ZLiTwzA
 FGHPg4auCnpgFxB2DbALdOlP1BpKrcP8rPwGWROnf8DToMPDZkq99KTxfQiFi8TLSrrdF4ol5pV
 b8VAUOU0JZZt8jhiAoFJtgg73XXcQLyTgQVGmJEfXrnbVngiwWbIa60lHx51yabXtng39n1X4Ej
 MoVNVtgnj8tEQgoeCzNRsmi1CF5FxtcwlhtojHxWZo8mtMM+WXoI0dLQV0DJuzPv3TlkSjiHOXM
 w5yyDUKcmU2hvpQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The functions drm_get_color_encoding_name and drm_get_color_range_name
are useful for clarifying test results. Therefore, export them so they
can be used in tests built as modules.
---
 drivers/gpu/drm/drm_color_mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index 3969dc548cff605cbdd3d56dceafb2ca00a5c886..509aa4325391340f8cfc50bd0fc277c48c889d3d 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -494,6 +494,7 @@ const char *drm_get_color_encoding_name(enum drm_color_encoding encoding)
 
 	return color_encoding_name[encoding];
 }
+EXPORT_SYMBOL(drm_get_color_encoding_name);
 
 /**
  * drm_get_color_range_name - return a string for color range
@@ -509,6 +510,7 @@ const char *drm_get_color_range_name(enum drm_color_range range)
 
 	return color_range_name[range];
 }
+EXPORT_SYMBOL(drm_get_color_range_name);
 
 /**
  * drm_plane_create_color_properties - color encoding related plane properties

-- 
2.47.0



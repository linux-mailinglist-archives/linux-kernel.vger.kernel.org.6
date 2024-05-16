Return-Path: <linux-kernel+bounces-181083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EFF8C773B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD1528565B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AF71509A0;
	Thu, 16 May 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ddpa9f6e"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC914F9C3
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864743; cv=none; b=e+ExBrUljjQLHfw0qpxb61i7LtFwe82EOntrEnB/0rUCYMQIqaAW6oFx7k8l7CfAZFRtTrnDaid8+hnBKtevEBtKt5YgTalpXaOAaGqY2HZjU0YsH31UAtrZdGRDZ8+gLA1vcADGV92mYEz/8w3R3oCZfyDvZEBPjucWn9Z0OdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864743; c=relaxed/simple;
	bh=akILSvu+vd0uaxT0kBqUrUilOOmGW8544rYfdZP+Ll0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2S4HVYuQKLp+b9IEosvoRnvwUMbonvs+/kkc0e2qia1jm9sjLivOEd4VjzfrUhmxoi28aJ8AAsSBYUlyQRocTUQF7KSeG17mlVVwXrr2NXYANYUjS3ExYjnhyGi1PPu7qJiUl6+h+rhZtCEQsWCGdpsq8S6xBUbEKegiL+599w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ddpa9f6e; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C316BC0003;
	Thu, 16 May 2024 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715864739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pbUUmy13w4guEulP+QztTkzQuy51RgJPVYnilwQVRo=;
	b=ddpa9f6eaUGQPFlHpfh/YMp6Mnw7lDQXi/MDHfDnn9eOaJNMrBGgsHVuVlRBkj/k8XgWjm
	1vMLG3549h0ZnveA/bfrQZKa46TS/+FPsihn4TtiSKtLYIm9OuLKF1ullGmz9JHYGxM9ur
	SuNfxazR6PkemdqfvTzdlTwfb1a6WzpqLiSKNFmjE9OLdmYcSvwfUgxiHNJY9sWCgIhHBN
	VC4/HyxX0DQj5kyU+uPzG2XKSBnwDftbdjCYXUBLJITIBlxu6FupxnQUnbD3b+L5GNsC2h
	u015LdC5LII80H+FAVkXZWO5nfMZf0Y/aKGEBtCbiAJpjwERoJwgX1p5sJUa0A==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 16 May 2024 15:04:59 +0200
Subject: [PATCH v8 14/17] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-yuv-v8-14-cf8d6f86430e@bootlin.com>
References: <20240516-yuv-v8-0-cf8d6f86430e@bootlin.com>
In-Reply-To: <20240516-yuv-v8-0-cf8d6f86430e@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=881;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=N9UhJoLZuEKa5YILFan7TkC9c/lglpLVoc0iCcUfoUg=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmRgSCuoeB5CPV4k/B8Z2u6DHIONHwZvy3rwVtF
 oktcNw6MoSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkYEggAKCRAgrS7GWxAs
 4hqJD/91SBexw17MtQT3uNnCai1j3FrxCnleqsfbP3ha3s31hZ91g/rtNeXEG/2oCEnB79y+Vlf
 reLV0+Mflqnn/uy3vaxZ5eGnqtV6Iz4mngwg/ZLBTN4vfgiqJrOLkFecoSTDbyaa3Zi8JpQI58R
 Q9L39bh/F+owK5CRM5NDCGLCMvqRpKNHO6DLVr3W5SqDrZu/12IIiJGPbBJfRV8I0WUJG2rXvDm
 Y4HBmRwEkMdpbhP0BUBi5qJE6nKSjlbaIeuxjKyR5vyERqd2WqYD5kB1VCd1UbXGg981KRwpAWD
 jDUrEYstAPMNObObNi3ep79B26/qMcDEMRD/nhjX71ZEN3kWVMkSS8vhhVrAelcE2f9thm4NMFN
 BgzSD4S7FvQQKXq5O78QhGYA4Tf5OT2yvqeV9C/ma0qONu8Csflaa5Z5/BihYY7gNp/K6ChEEwJ
 3KRIYUkINJEKTpGuRK/d5k5QgLixP70ILcNp/9qKe9vInkRtoiOccw8zVZXTs2qUvlqXsNm9dax
 0W5iakbdnDCqSSehplIpOJz+1EJ6Fnb0+4BvfnbvFp5Gh3eX5VCNNETv9iTiePy6sK3V4mCQ2iq
 OxEf4c0VtXlRciO/OgZ9W7ejXPrqw4ArkIN1y2HqtuiP4Aba9KMxHsn9D6WFoNSTb84iV5sQJO4
 ze9cXqeYEZexe8w==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

VKMS has support for YUV formats now. Remove the task from the TODO
list.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index ba04ac7c2167..13b866c3617c 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -122,8 +122,7 @@ There's lots of plane features we could add support for:
 
 - Scaling.
 
-- Additional buffer formats, especially YUV formats for video like NV12.
-  Low/high bpp RGB formats would also be interesting.
+- Additional buffer formats. Low/high bpp RGB formats would be interesting.
 
 - Async updates (currently only possible on cursor plane using the legacy
   cursor api).

-- 
2.43.2



Return-Path: <linux-kernel+bounces-437043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80489E8E5D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A95281379
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0D5215F41;
	Mon,  9 Dec 2024 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="amIaQuKz"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE012CD8B;
	Mon,  9 Dec 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735204; cv=pass; b=LEJvqV33kF3HrWmtTjJmPWi+ZPqXiw8jgq8KuEM4+C6IUgbbcjBwVSpeCogXugARPeLrfe5djJW7ZLQVzT7o6+Y3muGcINn6kmV0clJBDkeH6Xmq7oPvTRcBDKxKvIHmaqJCn2Vd5O3wYWKTIPA9+89NQJ6ciUyt4BjwJnThowI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735204; c=relaxed/simple;
	bh=PR8NjuIu/0uiB4VE/2Po/7t1NoLxydZ16mtOc3wKtrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpGkqNEQ3U+W+YRX+TmFfhTm8zDyHExKI18ofy0fcoj79/U4X/ASEeRtbSuEUMKlDX9olvgwVv6oYO1wbRf/AhuXraf4ZCSHVExAtiHvtzWtPCYsuA9fo9R7QgM5uEa0DmNjozyHzC5JJhsrQB0y5SztvoT4J0wMqh2/G5DEGfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=amIaQuKz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733735183; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Mz+UQReYQshJ6MMxDbGo4SAFcfg0z+IaMtRv/EfSC107L0OrSfrudcyOezbYBhlKOgn/d8gvkFRe0MLci1kp8JgtaZC+jdbADb5Z+WeNABMCIuePG8xjNq26oFs+BBz9XWnOBImyxc9DaeOfWVNIkHS9YU1LIkPXXA6AdaR0oIU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733735183; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9j3TfeakXn/etyTP/11ZyJkIzqm2+CfDvu6G/uE9l+w=; 
	b=UBFspgiCmTzdzspbY+sbBHYcsfmZZvF5fVnpbB2WCBWpu8jm++3rX6lO7Yu6wMZN8YlMbjGw8/N8Zd5hk5brw0LEsiFT2LgDmMcqMzzS48mZzJOUYMB714U1USSucgfrqfzx9wnTjmBHhh7dTfCMw/sYoHSMAIlTdBihsgJnayk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733735183;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9j3TfeakXn/etyTP/11ZyJkIzqm2+CfDvu6G/uE9l+w=;
	b=amIaQuKzJrc+svrL4PzUJ3ncO6Uqx9iNB4qkZ0xOcd6m6Gn8qDu+yYlzw83ZPrLu
	UAfAKBm4LH9iO5IYvyXrK4BeMs286wZId+PdNdE3osiDb3LlhawSwoRHFZds+2Zp9qy
	CjHR+iTnE8Sns6gnAmBQG/uEzuosev3a8umH1q/U=
Received: by mx.zohomail.com with SMTPS id 1733735181289810.7747919287581;
	Mon, 9 Dec 2024 01:06:21 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 2/2] sound: usb: format: don't warn that raw DSD is unsupported
Date: Mon,  9 Dec 2024 11:05:29 +0200
Message-ID: <20241209090529.16134-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209090529.16134-1-adrian.ratiu@collabora.com>
References: <20241209090529.16134-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

UAC 2 & 3 DAC's set bit 31 of the format to signal support for a
RAW_DATA type, typically used for DSD playback.

This is correctly tested by (format & UAC*_FORMAT_TYPE_I_RAW_DATA),
fp->dsd_raw = true; and call snd_usb_interface_dsd_format_quirks(),
however a confusing and unnecessary message gets printed because
the bit is not properly tested in the last "unsupported" if test:
if (format & ~0x3F) { ... }

For example the output:

usb 7-1: new high-speed USB device number 5 using xhci_hcd
usb 7-1: New USB device found, idVendor=262a, idProduct=9302, bcdDevice=0.01
usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
usb 7-1: Product: TC44C
usb 7-1: Manufacturer: TC44C
usb 7-1: SerialNumber: 5000000001
hid-generic 0003:262A:9302.001E: No inputs registered, leaving
hid-generic 0003:262A:9302.001E: hidraw6: USB HID v1.00 Device [DDHIFI TC44C] on usb-0000:08:00.3-1/input0
usb 7-1: 2:4 : unsupported format bits 0x100000000

This last "unsupported format" is actually wrong: we know the
format is a RAW_DATA which we assume is DSD, so there is no need
to print the confusing message.

This we unset bit 31 of the format after recognizing it, to avoid
the message.

Suggested-by: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 sound/usb/format.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 0cbf1d4fbe6e..6049d957694c 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -60,6 +60,8 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 			pcm_formats |= SNDRV_PCM_FMTBIT_SPECIAL;
 			/* flag potentially raw DSD capable altsettings */
 			fp->dsd_raw = true;
+			/* clear special format bit to avoid "unsupported format" msg below */
+			format &= ~UAC2_FORMAT_TYPE_I_RAW_DATA;
 		}
 
 		format <<= 1;
@@ -71,8 +73,11 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 		sample_width = as->bBitResolution;
 		sample_bytes = as->bSubslotSize;
 
-		if (format & UAC3_FORMAT_TYPE_I_RAW_DATA)
+		if (format & UAC3_FORMAT_TYPE_I_RAW_DATA) {
 			pcm_formats |= SNDRV_PCM_FMTBIT_SPECIAL;
+			/* clear special format bit to avoid "unsupported format" msg below */
+			format &= ~UAC3_FORMAT_TYPE_I_RAW_DATA;
+		}
 
 		format <<= 1;
 		break;
-- 
2.45.2



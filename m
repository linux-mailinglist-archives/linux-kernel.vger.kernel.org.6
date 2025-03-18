Return-Path: <linux-kernel+bounces-565905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F230A670DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328E13ADDD5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2380207A3E;
	Tue, 18 Mar 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Azt2FBf1"
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2F1EB5F8;
	Tue, 18 Mar 2025 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292717; cv=none; b=swknIau4Oxm0m9hESJK/LAw0iNUUK2loHmHT1iTzKY5s/ozgeXUsKpRg8Kcaj4lIOrhTipel6gFOfLx/UdSaZcoQC88kbCag1F4b0Wym4hEFTw0ZKsmyWxJi2kYuHvFuhmEBnols6Y2+4JCVj3CpZDg88TnkuHqNZelWP4qWalk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292717; c=relaxed/simple;
	bh=F1LgK53DLgHEw/QTvKY2iu1jDZDg/yZwkcwvTw6nH14=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=PSKp7aHq/Zo5wn8FU4oVfDJfBntnbA34XLy50h+jIEf3ohjzscTNQ7021wEF5ALqqelXnuS6iLLqTvuqzy8JKF5SkWLawZeGg+YOX8Zsiau17jETSBlfPEz9tzuofq03vTuzz1YYWxqxjpegfuxchYHWx97lvt0CwfDb+uAQ/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Azt2FBf1; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (web.docker-mailserver_default [172.18.0.2])
	by mail.mainlining.org (Postfix) with ESMTPSA id D92E9BBAC4;
	Tue, 18 Mar 2025 10:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1742292703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qXdpvh5mYCminn/8hmVBF6LkXE2iqtzozFhbE29SAHE=;
	b=Azt2FBf1VeLfTHFxORSXQkPyfyuwnoIGTVaOQLdjBzr6SKiAwOOcV5C6yxI+/EsAIqJJAw
	kcGBaucSKGhbcFfVYBKChStYMtPmy3LB08Cg9sFlH2xuIz0BYTFqv9aUwrbny7DIohxll9
	0XsOnWfrbW0/jJGxuXY5S4BVSECeqo2eJ+QLWR//+oINIdJrbIbPnw8+EmZn86PXirHOWj
	mDwHxNVVWtdAa92ferigIvmEsFc9UTqXpERsdlJ9FFqOW8TK/vDaY70xOd+8bz682mAQ+W
	dO2oKCzs/mlb2PB/pmfCYXAkqinF4dXJ6uvw+HwgcLazM8h6L1YGEtMWd11q9Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Mar 2025 11:11:43 +0100
From: David Wronek <david@mainlining.org>
To: Linux Sound <linux-sound@vger.kernel.org>
Cc: David Rhodes <david.rhodes@cirrus.com>, Lucas Tanure
 <lucas.tanure@cirrus.com>, linux-kernel@vger.kernel.org
Subject: cs35l41: Enable(1) failed: -110
Message-ID: <f7c97d53a38fb82ba8dab3b5c0c28b48@mainlining.org>
X-Sender: david@mainlining.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am trying to get the Cirrus CS35L41 amps working on the Lenovo Xiaoxin 
Pad Pro 2021 on mainline Linux.
Unfortunately, while enabling the speakers, I encounter the following 
error with non-working speakers:

```
[  104.028258] cs35l41 4-0041: Enable(1) failed: -110
[  104.028597] cs35l41 4-0041: ASoC: PRE_PMU: SPK2 Main AMP event 
failed: -110
```

I have looked into the driver and it seems like it timing out while 
polling the CS35L41_IRQ1_STATUS1 register.

According to the downstream device tree, the amps are connected over 
MI2S and are using an internal boost. Switching to a shared boost does 
not work, because the interrupt is never called.

I am not sure what I might be missing here. Sadly, Lenovo has not 
released the kernel sources used in the Xiaoxin Pad Pro 2021 which is 
why I can't easily check the downstream driver for potential quirks.

Here is my setup:
  - Full dmesg: 
https://paste.mainlining.org/ungeskriptet/66855caf17f342e9b030ffe0640e84de
  - Device tree: 
https://github.com/mainlining/linux/blob/f14a883/arch/arm64/boot/dts/qcom/sm8250-lenovo-j716f.dts
  - ALSA UCM file: 
https://paste.mainlining.org/ungeskriptet/33fe4907c000413fac94e5052215b1ea


Help would be greatly appreciated.

-- 
Best regards,
David Wronek <david@mainlining.org>


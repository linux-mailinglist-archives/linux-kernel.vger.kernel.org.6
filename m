Return-Path: <linux-kernel+bounces-543770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79268A4D9C5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CBD3A97A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DE21FDA90;
	Tue,  4 Mar 2025 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b="zhCCNJHG"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4BA3A8C1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082665; cv=none; b=hwU7eY/Sd8b4w22AmLsCXD15u3qzrYMl6oEJcnKRziCEZK3sWedvHrd8HRz1A5/Li2BNEv/tL4+44zNNMhye70pzSEo2q43gH0QojXGoxppQNkJAdqyKWfkUdZ0Mm8qYQsNR7MZvHS0QjuJc0uWMPW0qBKa76e6b2mri3ZHIsWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082665; c=relaxed/simple;
	bh=yWE4NFMb32ymbKXzAyjZlypfhbndF2yWyE0Gz8lHqIs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZxDil10jvSy9t3T4ropRHkEXZSNPr5w6kXotVYbZNRL6T6NaVqz0yIb89/4QkWkrg9zN3bV16o5QhxQRTth7KjGyNNaFEKb3dA/DE1StHiZsvfVuQJHdlvvW9wYK62RE04CbeBso23mb/4vayzKrF2P9QL/5J9fFgmvhYxxosdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net; spf=pass smtp.mailfrom=bit-philosophy.net; dkim=pass (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b=zhCCNJHG; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-philosophy.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bit-philosophy.net; s=ds202411; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uHUrptMcdZZF1KssGBJPZ8Qv5tqsSlJAZquM8l8ckrE=; b=zhCCNJHGH9c14yApVl0YiNM36J
	dGiGa7rlOO+lz2/31tzSSPvoIvLa4Z9X6QZG1avKi2dbUfQV0oo11fMN+/K5mlbeG7/oMUWLZtpHG
	NkZEl/doM76AEiSMGAdlLm239mto0IqhikS+O/XSEAx2ii3xWads3AFwx1Ng4yaQdY+2oGhHJ8hGi
	VGMqZKJzhq/CkWXn6rDDz9MhuwpsM7VFIcn33Z1MWaQ0HKfCzqtTlvghBcptom6/KEAt85u72fxz3
	J0nhTX45XWV3N2yfuZOUe5mizi7dbyU1a3YZAVMyjRcfUpdebgEzgTkOSSpsCjiH6hzARfU6orSw9
	eNcqtt+A==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1tpP8G-005yS6-GU
	for linux-kernel@vger.kernel.org;
	Tue, 04 Mar 2025 11:04:12 +0100
Message-ID: <0de29311-c614-4c5a-a08b-98ecb7541472@bit-philosophy.net>
Date: Tue, 4 Mar 2025 11:04:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe@bit-philosophy.net>
Subject: Wayland Vulkan X Graphics Kawai Etc.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Light.

I thought I'd share also some thoughts on Wayland, Vulkan X, Graphics, 
Kawai etc.

Wayland has become rumoured a big thing. It uses a W symbol. Compared to 
X, X is a good symbol for GUI design and exposed APIs.

Such as in Bit X, where Bit is how to design inner loop, related kernel 
constructs etc.

I now also added a Kawai O with I in it, as symbol for Bit X.

Shouldn´t it be best and symbolworld wise, to keep the X, and rather 
integrate the other efforts?

I also hear one "timestamps" each frame here. To allow recording of 
streams etc. Would it not be better to allow producernode to determine 
if one should record or not?

With jitter below 200uS one does not really need timestamping.

If the intention was to reduce jitter, or codeobscurity I agree with 
that. Not if it increases jitter or obscurity in general.

Kawai has become a big thing in games. I think this is good, and I do 
not agree with gunviolence in games aswell (questioning american 
gunlobbies who point to muslos as the problem), preferring the Kawai style.

One can also refer the prophet Ilyas for Kawai, Graphics APIs etc, for a 
complete and tight version of things.

This is fair pay compliant, (as my discussions often are about) and 
recommended.

Light,
https://bit-philosophy.net/




Return-Path: <linux-kernel+bounces-517505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A95A381D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1773B29A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0630F218AB9;
	Mon, 17 Feb 2025 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b="inf2TGDQ"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD62163AD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791944; cv=none; b=Jj/ObWLkw4YqxAsAOEHeqldavXnu26D8s3s9mLqf51T2fsW7O6tP+TtzA5PSVGxQSOfOEBZSxUPqkQl1WayKnLoCTE5YsS3zGdFrv2V/elHhRr4bcGkXfAixESnUikJh+GBZ3AvxXJ4/OpFhLXjWk/hwh0eYyxB1DJVn0Nhu3Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791944; c=relaxed/simple;
	bh=WRDbk0yBrRYzgbQtAYGyX58VuUpP9RBpyCO9qScYjvc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ACutH3ke6pqrzPeTqW44dxMKIa/oMMEtwO2OojV+oX1OHG9UmB3QS4HJfQxecVc33PUNhlOeJlqWMMbnlqngA6Zc6dQhkecwGE71gixvW9x5NpU/yKf3uwbRDKEFc7PhFKXQbPLf55vnhlSFfv9hKlbB5+SDXzdPLV73pQFNGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net; spf=pass smtp.mailfrom=bit-philosophy.net; dkim=pass (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b=inf2TGDQ; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-philosophy.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bit-philosophy.net; s=ds202411; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q19rlKQbvh59CBEI9E5yugGxZ0UHc92WInyc2Xo7jU0=; b=inf2TGDQjeGAmJOrrxAp3lEzy3
	XRsW0nYp9MQNzww0eQbWZjn+LvvtQopP0AgXDeWfPrMwPZsZgBDgthQ0g2o4w36a9VQbKDHj558Jr
	+p9IuaRYoBgh8+bT5xVYVcN+3GEt+NcA+xKzzYaFEex0LzXK0ZR1WsohfEBX2uwJqzyBchg1VIfO+
	xSJZjREU713S5EXBrkuflzbyh4zIQrv40CMwuZpUp59HXzm1g8+s1X1SsXDLP0HnG7g4Cb10kzu0J
	ZVWXmasEA6ByO6HKY54SFcWHhCY1lbuoR1ndtHPdEG3qC6m2r1eaCleL2s056M6hqC3T/juc2JWcR
	MHLbhKgA==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1tjzMC-002pCO-Su
	for linux-kernel@vger.kernel.org;
	Mon, 17 Feb 2025 12:32:12 +0100
Message-ID: <7a3c701f-aaf7-4707-a5fe-cfd7fc4b6ea6@bit-philosophy.net>
Date: Mon, 17 Feb 2025 12:32:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe@bit-philosophy.net>
Subject: BC (following up Bit X, Fair Pay, Low Jitter etc)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Men and Demons.

I have thought some about programming language.
I think some functions could be hardware accelerated, and more 
instructions could be used. for low jitter (more pr. clock and bandwith 
potential).
(RISC is counterintuitive to high-level paradigms).
BC would be somewhere between B and C and suit this.
C++ simly seems vain, and I think it is academic to know the correct 
developments here, and be with it.

Such as for instance XFS, seems symbolcorrect, very little complaints on 
this, and should be used.

BC also is symbolcorrect for programming. Unix was indeed based on BCPL, 
which again is based on Bit, and binary logic.

Bit also is symbolcorrect for an optimal inner loop. (including context 
switches etc).
X is good for userinterface, and APIs.

Light.



Return-Path: <linux-kernel+bounces-403235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AEB9C32DA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464701F212FE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B285F29422;
	Sun, 10 Nov 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="xT5bAb4u"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C36617BCE
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731250304; cv=none; b=NCc2JtO35WbUYBS/Qthz3mhr0wqWTTW4BIUnspCJHahaQUMxUxN73dkr+0fVMUMcUcygx5z3rBRGY0RSuhcfbiZdpMxjr3vdbsNDlvI58eWeEp+LXLgaYhPTcJQ6i/lhd7Ruybe+sbTQMWQBsaYE60qez2KE1N1njShRaptnnQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731250304; c=relaxed/simple;
	bh=L7wTZVOs8zACLd3w1V/xD+YauM16GswzKc8NvpnNUE4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TFMMNhqMW+YFHBRUjXxPNSy0uCJroMXUeZj03CiQvXcviYDFv4U4LYf30lpja4QBxrXLHKzMRY1FeNq8Lg+Qy+60ke9zrLYOVjjlOKNWLFigWXQj2oS58vK12XBJwhztNU2IoXamQV2cRM+xPAsVWbGH2Ypu0VTohOlbDJdiv8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=xT5bAb4u; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rovwVfA92aX8zM1zR0iEvK4EKSTbmIx/Zwmw0e8YmLo=; b=xT5bAb4uYw36qaDQax+7no79X1
	rsg0++n9l2T0bGlh01EmEvFU9yJfU/PzIFqzZSQzoV44L4TkKzv2kZieqcUWbqUy+BStM71BT4RHn
	deJWGUkvgSip5ZGrh7NGlnoMB7BA+BtWNs2kLWlhltuFdkM3wekcc54hiUk04G28fIWWzAJ9LNgyL
	PiUHJLRFStftFPs9EMmisVUYL9qiPUk5TOjgMcFJGOOf5h5gOkaQoPDfW8dqdagPZz40BJiCWpUVk
	JegTCMGeeGe5ss2MQd0a6OZqky29rOaVgZqG+ezRZr4nLFuwvMW3yXamkSjfyaf+Hgj5vyd+AS8nF
	X4VadJ8w==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1tA9Hp-003E1l-Jw
	for linux-kernel@vger.kernel.org;
	Sun, 10 Nov 2024 15:51:33 +0100
Message-ID: <31c6070d-b326-4f58-9003-e0d07a30fa44@bit-x.org>
Date: Sun, 10 Nov 2024 15:51:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
Subject: Bit X Philosophy Perfected! (harmonizes with Bit Coin (+ Fair Pay
 Politics) and Bit Stream)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hackers and Witches!

I most pleasantly present the perfected version of Bit X Philosophy.

Where the theo is O, and label Sami-Muslim. This is compatible with 
society at large, and only taking the correct of it.

The philosophy from before supports Fair Pay, and prices on files. And 
ofcourse makes sense with the development of Bitcoin and Bitstreams.

Indeed a dream once dreamed of many in retro days, of our own ecomony 
for our own abilities, rather than "Print and GFX card help."

I hope you will enjoy

https://bit-x.org/

Light,
Bishop Cærlyn.





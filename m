Return-Path: <linux-kernel+bounces-309970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CC396729C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55143283594
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B40E46522;
	Sat, 31 Aug 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=it-x-os.net header.i=@it-x-os.net header.b="FCa8MRXa"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934931EB5B
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725120582; cv=none; b=qpIN3gP4Pt5M6e+Aoe28twWj5EKFE8xmZ4SwqOOnlgk145vHYmeMTNjbJ2deNLmQqn0cCJGgojbf7kygN0pnFxIDnMBaWEpS8RJynK4X4R/MEPBCi0bsb2Z5gfFlDDJ7O3QRXvnJRoLJ56E8mR3VrjzRtoEnSPpOIWKokcwGlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725120582; c=relaxed/simple;
	bh=m0izhKYOr3XAJo1glcjmlSRJwGQgeLSXvcxdihnlX8c=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=APtnuGVpWESCxBox5UyvGi2q3/7/hwV5RlDShOPCN1iIo0+ha2DORkYAROoUQO0Vf+NQ/df2Usavbv8P10hYdTHA0G1y7YbBwLadt090h39zZVAghTbsdzMmhhGNoJntiCO57C2FHnBSLAg/NtHto8NGSe8NjRvCgo4ysERXKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=it-x-os.net; spf=pass smtp.mailfrom=it-x-os.net; dkim=pass (2048-bit key) header.d=it-x-os.net header.i=@it-x-os.net header.b=FCa8MRXa; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=it-x-os.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-x-os.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=it-x-os.net
	; s=ds202408; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=44/i5yyCRoxFOlH1ugzqSslez1cmPXZczwJJQa/0Gbw=; b=FCa8MRXaL2ifoNhlXVESBfVgrU
	EYIpypT+HWVnBT68s6DR5l9b3XSYjtYwV04ZHLHBvpFZF3PWYiaLtdNH2YPNq4ZpG9aFGnHHA4kWG
	/jo9lXD8Eqc+cOuqpNMqa/ubqg0JrXuuxZsf/7Ic8ovLs9Zn61tLypwVIfKNV/nIRkx6QCay1EEHo
	R+1A0ZFmTKNc4cPmxuZqiSteYYb9x9DMGZEVjk9/OZOuZUJAP5KwntF8W3bL+oDJlte6Hda0C9o4P
	DxZAFI7TyGHpZ/q8AuYCDP1bZb/oYnZjaiV5FxOp9AjOT/hBVOG93iPFQhlaAIItGoHrEfJPF8lZl
	urvukq2g==;
Received: from [2a02:fe1:716d:5f00:f940:7ace:518d:8015] (port=51091)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe@it-x-os.net>)
	id 1skQfM-00Cxpm-Ur
	for linux-kernel@vger.kernel.org;
	Sat, 31 Aug 2024 18:09:32 +0200
Message-ID: <01201e5e-646c-4d31-824b-f5ac27666a25@it-x-os.net>
Date: Sat, 31 Aug 2024 18:09:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <Ywe@it-x-os.net>
Subject: Mandrake.. is based on IT x (was fair pay philosophy, low jitter, red
 politics)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yes, I noticed Mandrake was based on IT x. So that can be turned into IT 
x these days. It should be very close. Then you also avoid the lawsuits 
on the name, a name I never encouraged myself.

IT is a general term, that is optimal for an OS, and related association.

Ywe,
https://it-x-os.net/


Return-Path: <linux-kernel+bounces-257246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52225937758
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE574B2168E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94326127E37;
	Fri, 19 Jul 2024 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=the-vast-x.net header.i=@the-vast-x.net header.b="CTnbfyG+"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5AB126F2A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390206; cv=none; b=UWJ3u36mZ8q5W3EGN92WSreIIwSthZVctEoyxz34xBzoYtxRtSTqXISniVLJZtVMBvbijo8SwwGxzrXLU5rVZiXS1i0/kBN3EXvcEe04/CCA9WYHDEHgvBhedK7J9t3ueShN1jaO5AhES8eJD2RIYZjcehjn7C/4NmigIVS89Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390206; c=relaxed/simple;
	bh=1fpK7WEZEnNNwGMliluDQoj6OKROLKQqE1zkh/W9qdk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qFws4EQ1eu1NjqEl4XLiSxeF/+fNL4dXpTOZMBG5nzhCc6bsFnreQm12uwFEdjPQPuBJ1au8eG4GcnaV61MxAS5c4z8uuQtkZwKt3ClLj6e2LM0O/zeDla4F18elyTxgIRxpkSDZxq8ZoR3VVOkheSmJKCb1ctH0cgvE8xttbyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=the-vast-x.net; spf=pass smtp.mailfrom=the-vast-x.net; dkim=pass (2048-bit key) header.d=the-vast-x.net header.i=@the-vast-x.net header.b=CTnbfyG+; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=the-vast-x.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=the-vast-x.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=the-vast-x.net; s=ds202405; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OoIlwytDcObNUiL0k09rKvJhQS2mv2ykGEeQGft79A0=; b=CTnbfyG+g+yD2O7GHQ/JHKA0Kp
	Yjaz76Fm2+H47XxiDSQabNE7cUluYSC5GgnYzHh+AwGWu364QGsAWcYaEdfkOjMh+lB14KPMLIT3Z
	/0neQJISe2YqQYvOtLmQTRNMIhX1aamaDeAXgVOfqbSI/HyhHBgABeSW6+mIUYtj2W/pYAvRe+DRo
	Oz44hjrgw6wrH/H8nUROHZ0zqBnw/CCPrl6N7B71yP6Lt7GUTrNaF+1SBG2AQHuxUOPdQkBOPSPiu
	R1NTnJg5EuErr8PNOEpO/V0BiMcr2VSMYEnvUT68bp0HFsgs391nO2u9pNYuAC51IZkPJY7kEjPr5
	Cv8zR2sQ==;
Received: from [2a02:fe1:716d:5f00:4de:7d42:835e:cd3d] (port=56702)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@the-vast-x.net>)
	id 1sUlx9-004COP-ED
	for linux-kernel@vger.kernel.org;
	Fri, 19 Jul 2024 13:39:11 +0200
Message-ID: <6d2fe7f3-3544-4167-b952-8f2ae26a2612@the-vast-x.net>
Date: Fri, 19 Jul 2024 13:39:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@the-vast-x.net>
Subject: bIT, the disco project that inspired Git (was low jitter, fair pay
 philosophy, The Vast X)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I did a bIT Dj set on Spotify 
https://open.spotify.com/playlist/0GvqMH5S5wpYWW2L0jzRUX

This is the project that inspired Git.

Check it out, if you like the disco branch of music. Note - many discos 
supported the development of Unix, and Djs too. With background in 
hippie peace and love, and praises of Raman.

The Light Be With You.


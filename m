Return-Path: <linux-kernel+bounces-177783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFBD8C4493
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8451C231D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EE115443F;
	Mon, 13 May 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="XS6GmiYr"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746E148853
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615469; cv=none; b=BXRw13UM5gQZCx2tI7v6rX4efVebopwfO0wlfq7ccd9SZUIHYKUxc28KHF29Xhg8jGXjl+A/Yx4xaZcWPZ49x+sAcLa0hfwGUhjhQPX1Hw/BhGyir6i+ecatmsPZMm6A8bOmkU3VlO/WuJFQAa6kUlAoK5ba6lZpCEhqe3EvAk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615469; c=relaxed/simple;
	bh=JJ0bDpp+2ly0j+2Il/m94d5l8HG2ea22zr+ewOV5QO4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bj8l3Kq/PdRPXGNuXyifVyGIfno/TBFOd3ymYtg3gvAXVQTY1mgMU6iOb8B2m6dZKatX7CMA71WAAp8leaFhz1vxKlqwK31coaYpVW/VUqvxCWffgbb5X8PeIpT+ZsYwpP0Qe28FptpVfMoJL4NwVcJha9iBLyXHpnxyJlFZzQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=XS6GmiYr; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N6nQqbqCCZPPGxfo7Eb1u8KoyCt8cX5NxFd+vLRkf94=; b=XS6GmiYrBjKobOpmtDFKVrZN+2
	BGUc83Fz5revGOIVbgX2aOPFpTMqLLU849UAYS+e4xQGNrLZOqT7Nze2LiaaTKXkit5SGe5M8R1WP
	p1+U19lkz3ZyVEaAQCgeZyBAouelAdniwsN0VQrPBqMI6uJLI/drRt/7BY5UCWY3PCHY1ozJrRITV
	G9q66VlduKanvbr0yU5QPj6GZdXZwwSgzPTd14Sc7RNF0Suzyl4ECLI0EAlZ1LqHpYfChld3HsHeP
	NEl/fAl5dYU6QDRBPBcKYYaldkjBo2f0ux8Zeq9CrvEpqfd5TgZy8ZhwdqcW+z+671YMX4ZFBc+jr
	SRhuyZwA==;
Received: from [2a02:fe1:7001:f100:7cf7:209a:3d9a:a84d] (port=50684)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@bit-x.org>)
	id 1s6Xx3-00AqQQ-Kg
	for linux-kernel@vger.kernel.org;
	Mon, 13 May 2024 17:50:57 +0200
Message-ID: <2fc679a9-e3f8-4faa-a248-eaa45d722047@bit-x.org>
Date: Mon, 13 May 2024 17:50:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
Subject: The Vast X, a more intelligble name (was Bit X, Fair Pay, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I found a name of The Deity, demystifying The Computer Bit, and making 
it more accessible to common people: It is about The Vast.

De-nerding things, and also encouraging an overall more intelligble 
paradigm for the whole system.

So the system is now planned as The Vast X, everything can be designed 
according to The Vast. I am also moving domains to the-vast-x.net

Auf Wiedersehen,
Ywe.





Return-Path: <linux-kernel+bounces-364409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B8299D44E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358531C215A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAAF1AD3E5;
	Mon, 14 Oct 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="T5ZrUomB"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D41E1AAE01
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922224; cv=none; b=U601yxcV3xZo2u7F6tdJC6NTPMd3J6fDdArjfw93rLZDNB0LdmgG4Goz3ybGmOcOWnfl0o2u4d2u8fQCgy/vhoj8AGDTwBdEYEC+xnHldjErqo5AiR+Vl3mneI3IeWl1h+voMBW0QzuPDUi9MFmrOaR1vEdNpoDywUJLmROlqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922224; c=relaxed/simple;
	bh=RjqO5/1towiWTqVhZoJTXM5ewaHoqGzr+aP2K82ayO8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=eVdrFChNPw/QAsZxaxYuXSbwnn2482lwVLe50wDqbzOwU23Qc16AUKFPHJYP+/XLqtLRknFIG+aJChBONQAPkCt0RJUQ7fSrB1389yCkJbEE9bD7S1KTAkpFnoSMXwEZEoTIl68lPOnCQZTIkHI7FLXhwZppvF9+Q+D7EemQ7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=T5ZrUomB; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ngmkueMnKJDTa1Pt5GFDI48sjoZf+u3NyTXK2CBxnA4=; b=T5ZrUomB3cl4NI6EtNYsvT6Abv
	swKxs+UvOk/19O1R78g1ExCKL4LQ9tzcSwt7DxdiyPS4VTqGwz5oAMjTV9ny7nW9xvQfwDUoOX0cH
	zAD5dLPXjLOGAS759JXH40mvNFE0EmJNH3WCVGO19P11p8YXLNrW5XGED6s8KuI0zNpkC+HzgQFOg
	yyim9lW4Ho6nshTOz7wH0hBQ7Sm5zfTa+fwQPCB5YkDf2/r/lqJzRd8vc2c36nAii+awYPYkdugOM
	fgRSmfDiwpuR8zdeEDfAU245ktlZI+hj+3QHINAN+H8B7rJH+k+vAQliQzCwfmJelwA5lefk3aq8z
	m2CPTLmg==;
Received: from [2a02:fe1:716d:5f00:f940:7ace:518d:8015] (port=64108)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@bit-x.org>)
	id 1t0NPE-0046o4-Qj
	for linux-kernel@vger.kernel.org;
	Mon, 14 Oct 2024 17:54:48 +0200
Message-ID: <daf85f8c-1000-472b-bb50-ca275eafcc56@bit-x.org>
Date: Mon, 14 Oct 2024 17:54:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
Subject: Perfection in Philosophy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, I talked about Low-Jitter, Fair Pay, Correct Philosophy.

I have now perfected my translation of Islam for philosophical background.

The Divine is then Ta, Prophet is Shuaib. that also is about the most 
translatable verses in The Corel. Follower is a Lumi. And many may only 
need these, togheter with Bit X. One has ofcourse the whole qURAN in 
arabic, as referance.

Light.
Ywe Cærlyn.
https://bit-x.org/








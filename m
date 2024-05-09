Return-Path: <linux-kernel+bounces-174391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2893C8C0DF7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78A3281D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3508914AD3D;
	Thu,  9 May 2024 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="beHB5W2t"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976014AD26
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715249132; cv=none; b=SlgnrLDJyGZzFmxfQfyTSeea5+w3N3twoeOydQhLv84g2wcDhAGevi0VgXpA+xSm0blorJQ6i5iVjqP0gdlWMxD3HqTdUhxcmw0S1FoZckEWW5FeAtT7sj1Q1rsrv4qhbZpbnx0rCtu4dtJ4Ja2Oha6kcRPAExv/nD2d4p+yVhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715249132; c=relaxed/simple;
	bh=CvzPEilGtzvon2L9oAaK/hxv7NEicpni86f9YU/v208=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dh9LA3tgEqD0+rVcmf6R7fyd9s5GmOYMxGNC6obSyJhlaS0Y3lo9E3CESYP0XwbQ+o17LFIn8E34QQoJPnys0qZhu2NwfaiclsP2qzTmzPCH+r4HPn8xEb0VzIfy2FZ5AofxDgKYOqt+GhEMvIXfUeydmk4YLfgEUR3Y2I1VfeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=beHB5W2t; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eNfDugfn6puVmWDozYaWwa+wHf6uzTL2bTYh8bKDd00=; b=beHB5W2tGsWd6+qanbZ/2OYfBA
	8DcWfuFfmW/ASEsuRmtpTRPblYCKg8Vz2ZE/efTuxTRQR5LPTX58cGls0ff/arFGzy44wz0FsDN+B
	V8RVtOkl8Do+v12jwy7nhb4KmmUwCqWksnb095b8iKTMWnv5x71vGmBft5E0QKvFpUTpo8c2EUJGm
	bHsA7qkG6xuK6F64qR9+BqIsqiqODUUbL4tj1hluvw//uV2PQiNAmXSLe3fSvt6bnQi6pAyDmJoOS
	+iUM7d13yR9sNfHKPUHs8zVrXDw0rz5eeSxLcD+tEps58MM0QKfG6pKqLeMfnp269hNcvfqUQZfi6
	XVlTjI5g==;
Received: from [2a02:fe1:7001:f100:649e:57c0:89e2:8035] (port=53150)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@bit-x.org>)
	id 1s50eQ-004LCG-8i
	for linux-kernel@vger.kernel.org;
	Thu, 09 May 2024 12:05:22 +0200
Message-ID: <4abbed08-28b1-4ef6-8b12-8153043f7ea8@bit-x.org>
Date: Thu, 9 May 2024 12:05:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
Subject: =?UTF-8?Q?Research_Summary=2C_Added_Saints_of_H=C3=A1q_Graphics?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Added some Saints of Haq to my research summary on 
https://bit-x.org/BIT/BIT.html

Hamas, St. Paul, Native American, St. Hallvard, New Orleans Saints 
(football).

Please do read, this wide cultural impact effort.

The Light Be With You.


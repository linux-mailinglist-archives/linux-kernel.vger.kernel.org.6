Return-Path: <linux-kernel+bounces-172694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF668BF588
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38378282EB3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2E917559;
	Wed,  8 May 2024 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="hxHzpwBa"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D716419
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715145322; cv=none; b=igvlcmSBdnOXZ87SgxrgkCwy8hwIJMmjA7HcMBTR2zev6LJUPyQmn8jNbSrMva6mPulCeJUmVUU630CxPE5jp9J207M9/oesGdO7Pyf0SofMk7IS7jdZg4ioHaXXywWgKl11p1Qv+d0RzkvdtEPx6l1EDhkYd+bpYg1JwhIo+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715145322; c=relaxed/simple;
	bh=CwILteTVVFdjDNg5dCjfA2fIF8UfjEGWlYTGc9Dqf/8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=B9YRDHiHPzTLYKVXy9/hwHyfAyR2HTGqtqXy3LCRO2dwmQn2/jKy0xZ5uJdCpz95JEQpb43WIttTNQZN1OecY6r3C9SBS3i6KGF0O1fCnvtKVGvAi6dWG+xFeKl/f/gpWKBp1oTVWds6RTjU2SaSeH5Nokxf69TnxEwZ5uyK2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=hxHzpwBa; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T0nX+BOlNNNrGDbMsnqBa7iQmBBTghYYCUKH0RzmnK4=; b=hxHzpwBam2l/L8J7OKIq8TMdi1
	pvmu+N9HidsatesOBPhl9W8NhBM99Ku1DlyBTf9tzhMnQYdgTlVPNj+/b8Rfj/tGRXlqEK9c4F8N6
	5Mi4LL/j6N5elYBxyQoZJ7Af8tUoHb8uPTnKcMlm2Bne3iKBb5ZwwJYTlxpLUwk7MVmJtaH0uvCJD
	ypFiKoG5Xwso2/qldybbu+Nw76g6OIbKz4xtEBiXn19n7maFgkVsJuZtjksgQFhCeqlD/9hx2T8DW
	xZvb2iDtOPo/br33NkNkYFlQncGmdk6YWUkM5N+bZNab6gnsn3b1Nzrjm4crB25ArK2gd3vOjkVDz
	7UCXjEQA==;
Received: from [2a02:fe1:7001:f100:4137:fb70:1484:5def] (port=64842)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@bit-x.org>)
	id 1s4Ze4-00DVJA-70
	for linux-kernel@vger.kernel.org;
	Wed, 08 May 2024 07:15:12 +0200
Message-ID: <e3b3b8a8-061b-45e7-95d0-1ff02282247d@bit-x.org>
Date: Wed, 8 May 2024 07:15:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
Subject: Bit X; Bit/Bi/IT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yes, Bit X, seems much a perfected concept.

Many people wonder about related culture such as Bi, which it is fully 
compliant with, which many gay follow also. And ofcourse IT which is a 
related term aswell.

I invite everyone to read my summary on https://bit-x.org/BIT/BIT.html 
which includes a little graphics on my research aswell.

The Light Be With You.
Ywe.


Return-Path: <linux-kernel+bounces-404562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BE09C454D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB76B28EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0221AA7BA;
	Mon, 11 Nov 2024 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="tpyNHHaH"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226141A2567
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350437; cv=none; b=qiREAXSsJNL70531RZZPFMzpyOCIRvKnAXkSIlH/XTm1WwjPT4hWuwGe909QqpYMsa4LAijhfoqy/QvzH/p93f0YtC7nbBPBCFfwxjzLvvipipfSAtKHKtiPlT3NZXKi4W+1nljhBSePuCmo9Jr4VOUYil6JpDD51k+mAnt66Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350437; c=relaxed/simple;
	bh=mYMvkJzRtBsjX3dNLdcWwCZGlzDU39xIT77Hm9Rq4LI=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=cAYo9UGTwtvS3dqqTUjQK91hqIp9r1aqiBYNGxLk1YJg17qtb4BaY6COmwSW9IReODohXSqDQmj4Y63Jj7SjxiRKFl1I+TlcrY6Vl5uspcRRZlT8C8kN9oLXb3q0QD/JZze3dFqpKKPSlwA0hcYc7Gk8h8rlfDvj+B8DR4L+Y5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=tpyNHHaH; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 65D4D2FC0052;
	Mon, 11 Nov 2024 19:40:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731350425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gjAifMeRjlujGtjlmYt5wIe4WkjPL7mFpFvfgt7JVcc=;
	b=tpyNHHaHCtQMsQtRJK31vJDmIRxDfVu3iFioqXC7zxF/HYI9a8NiCusee2P0Fz4Th/7U2O
	3pomKXXPF6w+nSlt4fWNnOLekEKPWObI68L8Nj/egEFEor5mdvx7Qb3ZuFmjClLctyNt3K
	7gYE+w43wva67oYtMqXhM/cLPCeg4mI=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <17276996-dcca-4ab5-a64f-0e76514c5dc7@tuxedocomputers.com>
Date: Mon, 11 Nov 2024 19:40:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Werner Sembach <wse@tuxedocomputers.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>
Subject: EXPORT_SYMBOL_GPL with GPLv3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

asking at the source: Can EXPORT_SYMBOL_GPL-exports be used with out of tree 
GPLv3 licensed modules?

- EXPORT_SYMBOL_GPL is documented here 
https://www.kernel.org/doc/html/latest/kernel-hacking/hacking.html#export-symbol-gpl 
but this only mentions "GPL" without specifying v2 or v3

- This LWN article only talking about "GPL-compatible" with no version given and 
that was written before the v3 was released: https://lwn.net/Articles/154602/

- This docs page 
https://www.kernel.org/doc/html/latest/process/license-rules.html#id1 defining 
MODULE_LICENSE(“GPL”) as GPL v2, but does not define MODULE_LICENSE(“GPL v3”) 
nor what is and isn't allowed with it

Kind regards,

Werner Sembach



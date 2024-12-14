Return-Path: <linux-kernel+bounces-445870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 136D19F1CDC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 06:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E743116200B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 05:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64AB12C470;
	Sat, 14 Dec 2024 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YDK8OgDI"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F93B3D96A;
	Sat, 14 Dec 2024 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734155902; cv=none; b=jfjg5i0y9UGhVxrAw3KOOEkxlPVMa/5A5KWpzFnR3AVPdbHUPucRHeWZP4PIHzp0fPD2ZpZ7lgqKanSE4j7gjtg/Q8bXBByPQDJjRrrkymH0dQYhnAKBSJ/QIu5uhZpEtlq4v4JNt949yIgxic8ZED1Ktg58w7L4q8iKLqa1JDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734155902; c=relaxed/simple;
	bh=PQWBTcy29TXNKN0U1b2wr3vHbGc0vm/8y6PD47Nqb5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScvsZT5mhJbj0QILFLAxdoJzMhAmVtQ4+pmN950tECLfBBx5Xe0+S7M4WBrfUFTHj+3uRCWQ5RRpMkUudRUK88kWYGS9DMCYz+hp68Q3rE8iAhXSRI/E5EpY4b/fY7Iif3YswijLIXgMpu7bFl+tWD+gOoAjfNLECWuhQBgQ8eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YDK8OgDI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=FM5I6cNvtUhZL1BdvPylUmVcFH6aL3PDTCO3nX7E4MA=; b=YDK8OgDIG9hdqANjUASV2whzd9
	RLCyLcu5bV5VxrWcwKxmZbvI1h37V8H6g3NpP4DoFeMDV4G+SELwjlrnMLX4aIKCpi0Pv70mJ3rxx
	JmqjO+X9tKnjbu6c/Brvg88dLaQ1m6l0U7jQGGz+QIIZ2TF2BvbLK5Sr8kWen3jDrBrUhdWU9Wy67
	zLO5Eq5mB+whCCLW28bUzEQMQP0jJTlpQshtAXF1ohyiS4Sg/diVK7gphVAqktQmkkpGFBoZceu+J
	6iKDQ3lUXZ7rnZbW3kD5VZSpl69xaswtivp/1+hD45zUSBPy9qvwcsPOk3NoIVHk6IU38Qu+cMD1W
	vVQM22KQ==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMLAN-00000004OqD-243k;
	Sat, 14 Dec 2024 05:58:16 +0000
Message-ID: <0f0c1e8d-551d-4b1e-a7dc-b91fbf1ff2db@infradead.org>
Date: Fri, 13 Dec 2024 21:58:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] docs: admin-guide: add some subsection headings
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20241213182057.343527-1-corbet@lwn.net>
 <20241213182057.343527-3-corbet@lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241213182057.343527-3-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/13/24 10:20 AM, Jonathan Corbet wrote:
> As part of the goal of bringing some order to this file, add subsection
> headings to help readers find what they are looking for.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/admin-guide/index.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy


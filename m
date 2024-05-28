Return-Path: <linux-kernel+bounces-192655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBAA8D2039
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262AB1F232E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F3171643;
	Tue, 28 May 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="R5KdY2NU"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E81E867;
	Tue, 28 May 2024 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909586; cv=none; b=H27ckT/2alLNqEy/1PiZvzQ3nPAf9zuaZUNe+aKlZx64nQCbuOZuYCycN3Pyj/g1V4ArWqbDpwi1CJLbXtBFkTqKpuYSwpLsDLbUDO4vlStW9S40SLD0toUb4wMjKKU5HgVqlxeHAIUo9sEj0pG7bW4uGwldMVXWG8tgui2yNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909586; c=relaxed/simple;
	bh=Y3hJrkKqkQX3Ls3M4zvv1kb9DoYBZ9ECkpeTzTE2Sbg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=acgNgmD/4AK9h62IDiuew6eKdjIBXV76hIQaryLnEMCmw2RmhaYFR1Uvt5iWDu5PtQoDAO0/60UXevGn0lvewj4kzNpvxUb+WU8FbC6KnBd3dhtYtCVwZGGhaTl2OsFkDYYzj0M796EVyCFNf9visRX47pwOvFY90ubwzB3CPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=R5KdY2NU; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716909563; x=1717514363; i=markus.elfring@web.de;
	bh=Y3hJrkKqkQX3Ls3M4zvv1kb9DoYBZ9ECkpeTzTE2Sbg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R5KdY2NU3al30H4QRt8D3lOTCZxRITPw8yl9ZHFDXW4mBBRTYM727mGt72mJ0FMW
	 LDSQz3nBj1i69+hGPzZkiofVL5hDvx69pFh0IFnfG9xgHqWfio+1SIF/lRbypilkG
	 D8WPpBfe2AoUXqRGiQXdeCuLJ5lOe1dEo8CvS62PNRYE1Hnmcl/PpNBuNRCKP1R+0
	 SegDgCNJB/NS7h8Ccp6gYRVSfom4u2H/EQH4gdAhqiBb00RTznGBk6+bYWAWnGuM0
	 oDvNu8ns/Lm0bVYyKhlV+WcEVh+QwSDupqqGp2o+9sL43Irh/o3Q1DihCfpvPnMpK
	 e5OOxALD5zt9j658NA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8kEP-1s7Hdi0MqX-00F8jK; Tue, 28
 May 2024 17:19:23 +0200
Message-ID: <0080bd18-58e1-4e82-96e0-e64d2fa978c9@web.de>
Date: Tue, 28 May 2024 17:19:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-sound@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bard Liao <bard.liao@intel.com>,
 Vinod Koul <vinod.koul@linaro.org>
References: <20240528063533.26723-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH RESEND] soundwire: fix usages of
 device_get_named_child_node()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240528063533.26723-1-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jbRx2sCDCPzqXpGNlf8SZ5seobfH1ZH4nHR0WRaxJmPCl4QrUJL
 9EWcb7BgfDjYh0ZwOEObhaUQ1sLD8MaURgwMy3soWt40sTlKY7mzJfjvpILx8L/seMawblz
 gqdmblbM4KeEOyEHL94og3HyIlxyOwzFFjg8AIV3+Y8e/uDSaCFrYNjVs9jJ2JZYbBzhBbr
 yAshy5oEBZVUk0XEs2sEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YsxEA9qA9Oo=;9EDX73XTQwS9zgO/5HsrY5WZCVu
 FOm+PlZ/bgHKNXGeOU172XV/sH6npcqsfYhzNJhI0K88jOX958OKK3pL0wuiPx/b66gwkQs6L
 BzUfbMKhdkVe4SM6OvELvsGQszHmG7RnOyiNjgS5F5DfVSdazmiXlhqp3ZaOGRpkWSAnNMgJA
 zQSXQ17k0tadD4ejwsjdOLMgXQyqX8EoRCamQmLhQehjO0gQkovwsBuW2OA4vBwjwPPmU5QGr
 toeZLDbxSqT6VK67bVy8JB/THFDBnSobDF34/svKGx1G/DZuc3ygd958lG5/dAnnb8jO7Sjp6
 2m1TWpSZs+5M/8Ni7zhyy+6W5K5QP7TIHHqquIUzCxwRq/q1ZV4ctHDdOsR038ukXsDsCEVJk
 JfutFSFbOyHRb6GLdKUB/ysMFvjgVDd+K/mTMbszT8Xn/yufJc9u09kg65A0a998EWMC9q1qd
 Xn9CCWjOZJxoItuK8aSal7rx70E0g/RbQATbxGTxt/e6zJ3Or88BSB1ijLQbC2EXwzDjWHyYG
 sGTmmcLWBCTj4U1caDBDg3JVOIaN8fK3JpGY5NVx0gfvJbW1oCQSUkQuqGvw2VQemrtS3iSof
 LlXXhvn7+WIL2Q0CzRoajEIQa7A2GCW/tF7uUrZtzlPKZEA4/0ObRoAxGyybl39G4Rbic8BZ/
 PvybX5pMj1SvUUB0ueykyXNffjpDxOE4uNUVzbRyz90BPwJsoC8AZabE+gS74Zh0RkSXHorL1
 d471OKjnzU/ZWSFnUj0ShkihGHtOuhxTSIuEyjHYC0Iai43JA6HR2G/cilfXGckPCg1OjwKku
 fNXaHiYaIBkVXrHU6fJE97U1LO+D4CvsnilOciF4f3zCQ=

> Add fwnode_handle_put() to avoid leaked references.

Are you going to respond also to my previous patch review
in more constructive ways?
https://lore.kernel.org/lkml/eb15ab0a-e416-4ae9-98bb-610fdc04492c@web.de/
https://lkml.org/lkml/2024/4/29/493

Regards,
Markus


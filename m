Return-Path: <linux-kernel+bounces-203773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1D98FE051
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B7DB224A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E893013C675;
	Thu,  6 Jun 2024 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="08oCavi+"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC513AA48;
	Thu,  6 Jun 2024 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660714; cv=none; b=djNTp337hVVXNoFahzP0ZVmkA609JhQfBEWzlCmPdsegYU5Rg/7irNpoDi9i0xVfNZ8bqpuGsBFzqu+wLTcr1phsmdILvusEld/W/+tZ5npdBKf0pSOObP2hKT5WM8ibgjIPtMDqd/UaAVjExz7DLvvRnUVCIwecKN5gQxhE91E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660714; c=relaxed/simple;
	bh=Cpqwp2eQ3/jCDknmCan0MWQAb6sJzKViBaYFh+gWbLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCSV0NpGHWEnCS/2jtdRAPd/C7rEm8Xb7N/5cT1DWz8ocd33WjpNfRppqgdeyg/8/11oQY9iGNQNdg3JkkRwPZv4yUdn680AK+g+lmDXWBJSh4/t+U0Kk4NceGbDX1C9EHS1lyrHF9QckgNu14UJVfw4r/qX9yG6p4H2CHv0S5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=08oCavi+; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Cpqwp2eQ3/jCDknmCan0MWQAb6sJzKViBaYFh+gWbLU=; t=1717660712;
	x=1718092712; b=08oCavi+qQxzSDXVV9GBTGlN+ti9gMqCrK7IbCeUvtiWUqkE7i5/ghcWZOn39
	+7EJbxN/uScM6U93g22mlkvSk+adUcKKlab2FbFW12xmCfsHG9WL6IRNisj5Mj6ftI/kSn0Y5LXF+
	4xaWFWMgKt9W0crSmvf14nimolp7QO5jangt8JiCEIzwk0udUdpUaFOVljUtw5SgtH3nHPd808ESV
	KZw+m9gtuVMgvtXcRBCWQ8hg3gcILNWY+kmhrqpOq+59bPlXz/FEdu3AJ4pzdZUB5jmsV4gBy6B1B
	OXMb5yUaHUIqQPVPPE49PPIl35l6Q9/66GfcDmg1rI/fJINuWQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sF80w-0000E2-6n; Thu, 06 Jun 2024 09:58:26 +0200
Message-ID: <8c0c615c-d27b-42c9-bd53-2199f0c81264@leemhuis.info>
Date: Thu, 6 Jun 2024 09:58:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
To: Hardik Gajjar <hgajjar@de.adit-jv.com>, Ferry Toth <fntoth@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 gregkh@linuxfoundation.org, s.hauer@pengutronix.de, jonathanh@nvidia.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_linyyuan@quicinc.com, paul@crapouillou.net, quic_eserrao@quicinc.com,
 erosca@de.adit-jv.com
References: <5dae4b62-24d4-4942-934a-38c548a2fdbc@gmail.com>
 <20240430153243.GA129136@vmlxhi-118.adit-jv.com>
 <8041106f-0be0-4ed9-990e-1f62902b30e9@gmail.com>
 <9dab0c4f-cfae-4212-9a27-518454314eef@gmail.com>
 <20240502152916.GA7995@vmlxhi-118.adit-jv.com>
 <64ffb6e4-d0c9-4e53-a314-a174097516b1@gmail.com>
 <7013cad9-7331-45be-b115-e9e1f253bcea@gmail.com>
 <20240510094520.GA8362@vmlxhi-118.adit-jv.com>
 <6f7b11ed-e387-4d51-b0f4-3af8d4e32a16@gmail.com>
 <fbc1a8c4-a459-4892-af75-d4176e606bd5@gmail.com>
 <20240528071851.GB188434@HI-C-003YD.hi.de.bosch.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240528071851.GB188434@HI-C-003YD.hi.de.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717660712;1a58b1d6;
X-HE-SMSGID: 1sF80w-0000E2-6n

On 28.05.24 09:18, Hardik Gajjar wrote:
>
> Okay, lets revert the patch till we fix your problem. Would you be able to send the revert ? or shall I ?

From what I can see it seems nobody submitted the revert since then.
Unless I'm mistaken could you thus please take care of that?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.


Return-Path: <linux-kernel+bounces-245811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F4992B9B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0071F25FFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2A158DC3;
	Tue,  9 Jul 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="sJzvxjyX"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD0515821E;
	Tue,  9 Jul 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528919; cv=none; b=TbiUajeygd7v30kj+UiiCWmZaxFMmLf8JOYM4KO2fPjg6+OX26vh2y8lqI31Mj0FlLUlYOXA9h1yhmokZ7GnruhNrh5cxkzhpiA9jzJxopkkhCp13xUiVKQBoYEhoDRkazjHdXMGWBYSlyiGYfTkuCq2/kpHk2kSUYWUHAvVkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528919; c=relaxed/simple;
	bh=TCDiYy0B5r09T63GQAuwabjoGpA2IUzYq0e5h49R2xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ogzacx+8q3aG3P8eG/uldIDUlgBLNCpD2J4jYOXk4tnF2Jpr4556PJCXKnisBmc/7VHnKLwtGdkaHhYAcmlzFQogUaNxM0wT7FfXeiEduLjCNM1YZ0kgecBYcA7LLXTo4vCe4mXtR68sm/9ME9Yq4j2XXYtPSCwMnMvlDqskiyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=sJzvxjyX; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=ziBWPyZuXFGkV8kVZKK0Xj6BNHEbLXnVYFACz7/URSM=;
	t=1720528917; x=1720960917; b=sJzvxjyXeNPWd/2fkdOEVFOHfCUVkv6GXeVmKNGTIf2ojdP
	ocSEHmIeeMUOuMPAjrwzwp2NxLBZxbmBjRTLUkFjlWDpzDonLUgjfox3lVdTIgjqROJTqkDVOIDso
	dYb8Nc2Ea6aKDNAyEwgDutkuMW82Ru03ZSCzyhuTLJFFS91mr+jbm2139Gl6xDNvINyO8ZFNdKI3i
	+LK24AuDwzH8iaSzMblz++sM4jDQ4iw6Q2il/0uRgVhXwgSgvZZADqcyXps/t1oy1dZfdFN310B0L
	rn3OOtuB0CaR5IZhtcgw6D8eWBz3M5DiVs79HPOdYgPAe2sU2D5U6/I4qIZ7RIOA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sRAAN-0006uA-4B; Tue, 09 Jul 2024 14:41:55 +0200
Message-ID: <af91ef9c-5050-4f16-898a-f0c02a293d3f@leemhuis.info>
Date: Tue, 9 Jul 2024 14:41:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac
 cause appearing green flashing bar on top of screen on Radeon 6900XT and
 120Hz
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
 <CADnq5_PDxJ8O1JUQ9RBYRFB9G1WZJos05ZAM4jUKuPBwPxjNkA@mail.gmail.com>
 <CABXGCsNN9LwHc2x2AAEH=5UNwpvkWkBqRYz3OP8MZ6Woy+HDXA@mail.gmail.com>
 <b6c440ca-e63e-429b-af41-5f27d4b8b2a2@leemhuis.info>
 <CABXGCsNoFfMn7LaqqFgEPg-ECyUPN=f=SXVrFi=GZk6c69-Gqw@mail.gmail.com>
 <CADnq5_PDSkr4hOHJmb1J30UC0a7sXsm5-TPkEmjzffMK_A+7ug@mail.gmail.com>
 <ea465a40-f673-42b1-8b1c-a2efb20cd562@amd.com>
 <CABXGCsPyrUEqDq2gbr4VLw5ncd9cKoCZ9nOr2SRfg8Lh=9H5Kg@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CABXGCsPyrUEqDq2gbr4VLw5ncd9cKoCZ9nOr2SRfg8Lh=9H5Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1720528917;5dd8eef7;
X-HE-SMSGID: 1sRAAN-0006uA-4B

On 30.06.24 01:18, Mikhail Gavrilov wrote:
> On Sat, Jun 29, 2024 at 9:46 PM Rodrigo Siqueira Jordao
> <Rodrigo.Siqueira@amd.com> wrote:
>>
>> I'm trying to reproduce this issue, but until now, I've been unable to
>> reproduce it. I tried some different scenarios with the following
>> components:
>>
>> 1. Displays: I tried with one and two displays
>>   - 4k@120 - DP && 4k@60 - HDMI
>>   - 4k@244 Oled - DP
>> 2. GPU: 7900XTX
> 
> The issue only reproduced with RDNA2 (6900XT)
> RDNA3 (7900XTX) is not affected.

Hmmm, again this looks stalled -- and the regression report is 6 weeks
old by now. :-/ Or was a solution found in between?

So I assume no solution will be ready in time for the 6.10 final? I also
assume a "simple" temporary revert is not a option or bears big risks?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke


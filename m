Return-Path: <linux-kernel+bounces-382893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71D79B1498
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F771F22C01
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 04:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD513CA99;
	Sat, 26 Oct 2024 04:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="okGGH3U9"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D668470839;
	Sat, 26 Oct 2024 04:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729916371; cv=none; b=W7uaLdNsxxCon85fV0jV6GqhqIy0Qt70hA7gnLespl8XOdPUAufe5tC3HMyklpwDxs6pN7EYTGtOypj2zlYzUkFCXzZfexMUV+oYFTqNogo1PsrMuneaguQ5IgLel7R5BiGiMdoc4wJfgEfok1WUEDDGEyG/prcuGFPoVmMsvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729916371; c=relaxed/simple;
	bh=QF+b64E6Z64yLZtb0mdNWAFz1DlSht3AZjbESiYcnjQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DpKt6NWxKkmEWtWtPv8NmptPf0vyHWEP7mBdU3NKNxhUAtDLEdi77HY+/yw7vIGmAP1wLaRyBhpJCczVwWgsYt7mk6K5VUuLoLKsGanKUxmAt9FpHADyCrGzmKvEo/kFiYOfvkURH2MMPKzixaxXAkx6zOaNrcL1S1N9ODFEyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=okGGH3U9; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CEB7788FC7;
	Sat, 26 Oct 2024 06:19:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729916368;
	bh=rUgz+85ZCTleGup+KKsBwhgV3yR7VpBnRn+6UGMEBo4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=okGGH3U9b6lgdW63Qe2C1VuQJGP0hP6Pvjb2/RmIvKvTnujBg23XwysLSgrsvXeGr
	 5jOFOCVOato2SHq55DdQ3DsU9NSvhSoEcHU3VYEVKBv/xNUGWiMUPJeTjKlFP8cI6F
	 9SCt35S/QOq371ARytR3j49mH8kj6xnAg+YpKKjrnsO0ip6O1QVhPMXMragX+l6xc2
	 81oHHvu5GJ0OpM+PKJB0BSRuXxBXHsMo63InX8ocGnmY3k0yZup4JXybXtcBgfNlP9
	 YSDZG8IZlzLA84ZrhH1FHWMyI22IzCDsPcwm9JTvXbYvlBjVcmQcway+daph/vbbCh
	 N/AO5OVfhTdpQ==
Message-ID: <d2b8f767-c5c9-409d-a6fa-1c101b90c9fc@denx.de>
Date: Sat, 26 Oct 2024 01:15:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: core: Check read_only flag for force_ro in
 bin_attr_nvmem_write()
From: Marek Vasut <marex@denx.de>
To: linux-i2c@vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org, Thorsten Leemhuis <regressions@leemhuis.info>
References: <20240713154001.107439-1-marex@denx.de>
 <c181a856-164b-41cf-b512-b8dba3247ae3@denx.de>
Content-Language: en-US
In-Reply-To: <c181a856-164b-41cf-b512-b8dba3247ae3@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/25/24 12:42 AM, Marek Vasut wrote:
> On 7/13/24 5:39 PM, Marek Vasut wrote:
>> The bin_attr_nvmem_write() must check the read_only flag and block
>> writes on read-only devices, now that a nvmem device can be switched
>> between read-write and read-only mode at runtime using the force_ro
>> attribute. Add the missing check.
>>
>> Fixes: 9d7eb234ac7a ("nvmem: core: Implement force_ro sysfs attribute")
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Cc: linux-kernel@vger.kernel.org
> It seems this bugfix is not even in next, any news ?

This is still broken, bugfix is available for three months now, but not 
picked up. Any news?


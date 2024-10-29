Return-Path: <linux-kernel+bounces-387222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4600A9B4E23
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE51B23585
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C09194ACA;
	Tue, 29 Oct 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="mwlKU0wN"
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE4919413C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216166; cv=none; b=LX4G3bwiXG3dbhhoqLs510c1PHjBRXeC3aIYkCbcTvQRIv6TyUFPYxhvz/+fLrw89ul8xC4fTRhSGYaFYgVe8+tms3RmsIMzSlOW66h13EgX0eQcrxL+5rB6/SL02QKZGr7haR7aQ28WGC04mQTqk8hyGjft3PkVywiNyINdxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216166; c=relaxed/simple;
	bh=/fpG2GGUWbUH06HgZi2peKYBsU1bofywwwD42xbLIQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjNTTZt8nXlsevswEHiM2vCR8HdxDmqjA5bGL7yEe6U/gsRYMTG4cybsV74RjvTrVv8igSyAcGdxMTR4G6mS9be5mVdxV9oTM5hIOhlH8cADJ1VnlZ7s08XSO0qJSPCv3LKj8Rhr+vUKwgPcnj4DzITK86JS9qrx0YSuYxYUky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=mwlKU0wN; arc=none smtp.client-ip=17.58.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730216162;
	bh=puxcM7+qXLjSwz68WBl3v2znnK9nvbamWejoVMBg5Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=mwlKU0wNVYj/f0QuLQyW332g+Rm694/Ue89y0qaiSnkuy9Ya3arYo56nduii5yvN2
	 3UUnBADolY9vEMa9u33v3DHb5k2O2AQgmpgIjKmmUvAnkOxVx2T5T7iC1SKf2sPiTD
	 8mqbUbZRTut2qd4odYJQCnr8BCOfAkJdl788hzyG+lW3yqSOKNgO5Tyy0Xid7hvd+j
	 fIZIk0Fn6gNuJvNI2i+Rh2C3oaAv8JEhcaCAkAtMfYADzpBg5EuOUAKr5mujpR20XQ
	 ww1pk+oV05mvBd2t0Q10wQkkQHburN8zp1ribRexuH1+ulrPIkJEKeGYNGlXO49pNV
	 v7gnhFuu8rVCA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id 148CD8013C;
	Tue, 29 Oct 2024 15:35:52 +0000 (UTC)
Message-ID: <a6d7efe2-ec92-4ffa-a1f1-bc73ebd49d16@icloud.com>
Date: Tue, 29 Oct 2024 23:35:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] phy: core: Fix that API
 devm_of_phy_provider_unregister() fails to unregister the phy provider
To: Johan Hovold <johan@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Lee Jones <lee@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, stable@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241024-phy_core_fix-v2-0-fc0c63dbfcf3@quicinc.com>
 <20241024-phy_core_fix-v2-2-fc0c63dbfcf3@quicinc.com>
 <ZyDmdsHtxo-gFIFH@hovoldconsulting.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <ZyDmdsHtxo-gFIFH@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XeQvugf_b68p5An_VnUiKVZ6QSUfRYln
X-Proofpoint-ORIG-GUID: XeQvugf_b68p5An_VnUiKVZ6QSUfRYln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_10,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=961 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410290119

On 2024/10/29 21:43, Johan Hovold wrote:
> On Thu, Oct 24, 2024 at 10:39:27PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> For devm_of_phy_provider_unregister(), its comment says it needs to invoke
>> of_phy_provider_unregister() to unregister the phy provider, but it does
>> not invoke the function actually since devres_destroy() will not call
>> devm_phy_provider_release() at all which will call the function, and the
>> missing of_phy_provider_unregister() call will case:
> 
> Please split this up in two sentences as well.
> 

good suggestions. will do it.

>> - The phy provider fails to be unregistered.
>> - Leak both memory and the OF node refcount.
> 
> Perhaps a comment about there not being any in-tree users of this API is
> in place here?
> 

okay, will do it as you suggest.

> And you could consider dropping the function altogether as well.
>

Remove the API devm_of_phy_provider_unregister()?

i prefer fixing it instead of removing it based on below considerations.

1) it is simper. just about one line change.
2) the API may be used in future. the similar API of [PATCH 1/6] have 2
usages.

>> Fixed by using devres_release() instead of devres_destroy() within the API.
>>
>> Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Looks good otherwise.
> 
> Johan



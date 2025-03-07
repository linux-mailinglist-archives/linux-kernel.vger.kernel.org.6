Return-Path: <linux-kernel+bounces-552076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E8AA57518
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F99517765F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7392E259C81;
	Fri,  7 Mar 2025 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="arF2/790"
Received: from p00-icloudmta-asmtp-us-west-1a-10-percent-0.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-west-1a.k8s.cloud.apple.com (p-west1-cluster5-host9-snip4-3.eps.apple.com [57.103.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DED258CFF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387527; cv=none; b=ILjvWyHtSUS7WxPACV21MDHnsTel/MN1sXTBD2vW8VGpGdMDsKtwHNBRf/6REpfoxEvLcBO3WTwt2l2Sz3oYdtmhuqknk1wVQR3no59709GsfRm/78k9zp84ZsySduq8IYQsyof+ejoMUv43azI39zpwuWaVvYQCFSwk4E9Vnik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387527; c=relaxed/simple;
	bh=8D33UMR4UvUDUQipXJRI98FhV6DGIx3yTYvijJaZDpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMlLQTtnBozL9Ef6hfRUu/XUZrZDi2MDPIowBYklnP8fVyo65/lP0id1sD7d4skvEHN5t5JwKMrnlHW5E6e2xO8kRbSm0x06W2+h5aL9b4/n2cQpVisSbNil2qfDVtw8fUV7DM+kq9Zl3Bd++EevJZ5WjWQfdDNQKX8D4PPUwtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=arF2/790; arc=none smtp.client-ip=57.103.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=V6HnvG3h8x+Obm8xDLKX/nEgo1l4dVajtmIeyOJkgB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=arF2/790dnJl2X9vPDjH2Y6wyEeq5EKsrAc776jQY2I1+nlneXQTmDbFISkbqqwtA
	 bI16iZ/dA/hVmRzwX5dibs1gQjQEBEH5CwzbB1kwPbgvZKFw21ho3LG6NgO4kKSnNg
	 3AzGlWujC/O0KGCx/iDzciQOBnCad6eDBGRDUBldKdg2hKyp9eZOFGyEC8KIBJWHgc
	 ka8sqjiQFFhU7h53v31UoyLa3eMNGqnTSp9if1kPLGSIuWtlFwl7rNUvRtAWKOI1eP
	 TCiGicqWN086kiMAw8zEoKyjKKtoAhqKrGxBP5cqvc01RjA8neN6oQHZu4GpVnLAiw
	 wFDqD1flul6yw==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-10-percent-0.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-west-1a.k8s.cloud.apple.com (Postfix) with ESMTPSA id D91A41800D55;
	Fri,  7 Mar 2025 22:45:22 +0000 (UTC)
Message-ID: <245f2248-e655-40e1-b1b0-6d99a5b4f365@icloud.com>
Date: Sat, 8 Mar 2025 06:45:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: faux: Check device binding state by
 dedicated API device_is_bound()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250307-fix_faux-v1-1-91459764575e@quicinc.com>
 <2025030704-lapping-gurgle-d101@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2025030704-lapping-gurgle-d101@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BsNrqDFay2CNcigDokSlrcBjtWauQlNi
X-Proofpoint-GUID: BsNrqDFay2CNcigDokSlrcBjtWauQlNi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=560 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2503070172

On 2025/3/7 22:04, Greg Kroah-Hartman wrote:
>> -	if (!dev->driver) {
>> +	/* Do not need to device_lock(dev) due to no race here */
>> +	if (!device_is_bound(dev)) {
> Ick, this feels wrong.  This is the driver core code, it can poke in

both 'dev->driver' and device_is_bound() is okay with this very special
context.

'dev->driver'    :     is binding or have bound successfully.
device_is_bound():     have bound successfully.

device_is_bound() may be more accurate here.

> dev->driver if it wants to, and as the lock is not held, and there is no
> lock even mentioned in this driver, the comment is confusing unless you
> dig and go read that device_is_bound() requires this.
> 

agree.

> Also, when we start to add locking requirements to functions like
> device_is_bound() (which we really should) this call will fail the
> check, right?  How are you going to explain that?  🙂

Generically, for 'dev->driver' and device_is_bound(), device_lock()
should be hold firstly to avoid race as driver core codes do.

this patch may be still okay if device_is_bound() is changed to
bool device_is_bound(struct device *dev)
{
	bool ret;
	
	device_lock(dev);
	ret = dev->p && klist_node_attached(&dev->p->knode_driver);
	device_unlock(dev);

	return ret;
}





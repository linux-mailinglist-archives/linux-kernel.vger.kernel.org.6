Return-Path: <linux-kernel+bounces-329880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7073D97970B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EC31F21AB0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7091C68AE;
	Sun, 15 Sep 2024 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="NiN6nj5r"
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC4C3BBEA
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726409758; cv=none; b=LvmwjiVRYLbBIrs0u7UUkIDfbU8U0p3EhP3/0mi3MjZlRTCpan5mubhVYyEO3Dgwv0VU51CTQ/eghDOl7fIs4pBTb/RfZLUiiuqmAPr0WgKtO8cbzseh+P0tnTg26VByjEb7mLemo2TF1YSpyKiO7qmBlFtlfRHam8YqGDKhKX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726409758; c=relaxed/simple;
	bh=zB6M2xujkz30L0S+Kn7RrC2C2vjQWBmg+Ot+RgxBqos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvAbBMFwyL+hgQWqR4gKeJLLNuYfAML//HO0WmXGYsbCbJStT2VvxJ76dJTgtltMJtUiRn3kB77WW0N4XpVlyDjpJdi01/oJyYJPBlLkH8yAFo9choon0aig59dzNRquc5klaInNRs1kKkx8KVA1m0tjzapZA6Uo6Gim6NaQo2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=NiN6nj5r; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726409756;
	bh=b8gJW4O9VasEYHWibaV2iIlZW+C/tFVTtoCFhlxXCEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=NiN6nj5r5VWQNVeLLD0Ecjq7TV13HO/bbgvNtssfz5zevSNOw5R5inDqafZPZOvJb
	 LzzbaO+2XkBiXDnHW6OSaUxuSdw81lIr1KGzNa8s122eY2DNIItYtw8GnuAwgVzRu6
	 O7ZqLLpmbSplHQl5OUrlXi1Ov/OyGEGFwszydjWvEH+4glBi0gOpEpOJ5+5+yamJnD
	 nbuX7lUIR9yXhUM3ni2dXE2b6nyiniE4RWhAbV62HC7aoFP2ZjRZUzF7aCjnU7LSi0
	 xdAYpym7T0sWDgyPRG8mNqdNYV2nBKnUEhb52R3aGWEduXk/wBGAj6GBNO/E/QNpjG
	 M7hNOH07KKv0g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id B90D63A1381;
	Sun, 15 Sep 2024 14:15:51 +0000 (UTC)
Message-ID: <2ef86bb7-def3-4e2f-b4c4-f054b17bcbc7@icloud.com>
Date: Sun, 15 Sep 2024 22:15:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: bus: Mark an impossible error path with
 WARN_ON() in bus_add_driver()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240915-bus_add_driver_fix-v1-1-ce5cf1f66601@quicinc.com>
 <2024091530-antacid-magical-8302@gregkh>
 <8620a8a6-9101-4f53-858f-2e09aa310d16@icloud.com>
 <2024091540-scrubber-navigator-4aae@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024091540-scrubber-navigator-4aae@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YSM1KLVM7-SAyb8dlAIYV_SxFxzZsrfY
X-Proofpoint-ORIG-GUID: YSM1KLVM7-SAyb8dlAIYV_SxFxzZsrfY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_06,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409150109

On 2024/9/15 21:55, Greg Kroah-Hartman wrote:
> On Sun, Sep 15, 2024 at 09:38:15PM +0800, Zijun Hu wrote:
>> On 2024/9/15 21:00, Greg Kroah-Hartman wrote:
>>> On Sun, Sep 15, 2024 at 06:22:05PM +0800, Zijun Hu wrote:
>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>
>>>> driver_attach() called by bus_add_driver() always returns 0, so its
>>>> corresponding error path will never happen, hence mark the impossible
>>>> error path with WARN_ON() to remind readers to disregard it.
>>>
>>> So you just caused the machine to crash and reboot if that happens
>>> (remember, panic-on-warn is enabled in a few billion Linux systems...)
>>>
[cut]
>> what i want to show is that this error patch will never happen here
>> currently, so readers can disregard it.
> 
> Then just remove it, and document in the changelog text why it can never
> happen.  But if it can never happen, then why is the function returning
> anything at all?
> 

the only condition for driver_attach() returning error will be
impossible within bus_add_driver()'s context as shown below:

int bus_add_driver(struct device_driver *drv)
{
	struct subsys_private *sp = bus_to_subsys(drv->bus);
	struct driver_private *priv;
	int error = 0;

	if (!sp)
		return -EINVAL;
		....
		
	if (sp->drivers_autoprobe) {
		error = driver_attach(drv);
		if (error)
			goto out_del_list;
	}
...
}

int driver_attach(const struct device_driver *drv)
{
return bus_for_each_dev(drv->bus, NULL, (void *)drv, __driver_attach);
}

int bus_for_each_dev(const struct bus_type *bus, struct device *start,
		     void *data, int (*fn)(struct device *, void *))
{
	struct subsys_private *sp = bus_to_subsys(bus);
	struct klist_iter i;
	struct device *dev;
	int error = 0;

	if (!sp)
		return -EINVAL;   // this is the only condition for
                                  // driver_attach() to return error.

	klist_iter_init_node(&sp->klist_devices, &i,
			     (start ? &start->p->knode_bus : NULL));
	while (!error && (dev = next_device(&i)))
		error = fn(dev, data);
	klist_iter_exit(&i);
	subsys_put(sp);
	return error;
}

int __driver_attach(struct device *dev, void *data)() will always
return 0 even if it has int as return value type.

> thanks,
> 
> greg k-h



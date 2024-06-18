Return-Path: <linux-kernel+bounces-219496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54E390D378
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE69286E83
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1E915821E;
	Tue, 18 Jun 2024 13:42:09 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4B014D28B;
	Tue, 18 Jun 2024 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718129; cv=none; b=stJ6wWUMPMwx4M74k1Yi9FDEXChSjovlGXq55biSx6gmfgoYUdfoIBorSgZIPrgQj03JfFhljelodaZ+8ZL1t/U/LAPR9BhZ/rI1niU5RnnjqVYTqYg26h3vwwv9BSOXSp8+rQUr2yQQ6CW1Q+Sh/ZRhMKfrp4+QphodvScvSDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718129; c=relaxed/simple;
	bh=XZ5Ip0vEkELYlpJVYlAIIi14tr2eSm6vDwYN1t4OyXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ad5/sIlv/uIkHE8MiDdobP31xopDflJmZjsGUzohNbcyoNmYKxidwWCU0Z47zB6TNTaX85fyoV3Q9lMVj5IvbPWGCf/Q0wE/+k0italnfI6i7B1Q8cEjbnu+YhKf7zYYFcm4y/UvsTIdEG/SKWS6DF5FJ2ZXm9XI2gmC9aYK7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.225])
	by gateway (Coremail) with SMTP id _____8Bxb+uqjnFmxOwHAA--.31604S3;
	Tue, 18 Jun 2024 21:42:02 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.225])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxBMWmjnFm1JMnAA--.19761S3;
	Tue, 18 Jun 2024 21:41:59 +0800 (CST)
Message-ID: <0140ba47-5657-4df5-afba-39bcd77200e5@loongson.cn>
Date: Tue, 18 Jun 2024 21:41:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 RESEND 1/1] zh_CN/admin-guide: Add
 zh_CN/admin-guide/numastat.rst translation document
To: Tao Zou <wodemia@foxmail.com>
Cc: alexs@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, wodemia@linux.alibaba.com
References: <d9ee8cc2-8fd9-4a99-9673-b3a56187df95@loongson.cn>
 <tencent_262FCAE8F01C8D0582A45600851988585806@qq.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <tencent_262FCAE8F01C8D0582A45600851988585806@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxBMWmjnFm1JMnAA--.19761S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZw43Kw48tF18Jw13tF4kXwc_yoWfCwcE9w
	1F9F97CrWUJF18Kw4UKFsxCr4DCFW3JrnYvFWqy3yDuas7uan3WF93WF93X3s3t3yI9rWq
	kFn0gwn2kw12gosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb38YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_
	GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjxU466zUUUUU

Hi Tao,

在 2024/6/18 16:44, Tao Zou 写道:
> Hi, Yanteng Si. Thanks for your suggestion.
>
> On Tue, 18 Jun 2024 12:01:33 +0800 Yanteng Si wrote:
>> 在 2024/6/18 10:47, wodemia@foxmail.com 写道:
>>> From: Tao Zou <wodemia@linux.alibaba.com>
>>>
>>> Add translation zh_CN/admin-guide/numastat.rst and link it to
>>> zh_CN/admin-guide/index.rst while clean its todo entry.

We already have checktransupdate.py, make sure the script detects it.

Just need to add a commit tag of origin document. like:

---

Subject: [PATCH] docs/zh_CN: Add driver-api phy translation

Translate driver-api/phy.rst into Chinese.

commit d02aa181ee59 ("phy: Add devm_of_phy_optional_get() helper")

---

See:

https://lore.kernel.org/linux-doc/87plslonqu.fsf@trenco.lwn.net/

https://lore.kernel.org/linux-doc/5351308d-6fb7-4179-b0a0-32107d8244b7@hust.edu.cn/


Thanks,

Yanteng



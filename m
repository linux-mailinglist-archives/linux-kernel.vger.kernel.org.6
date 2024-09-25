Return-Path: <linux-kernel+bounces-338309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CAC98563C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6E71F24145
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F6315B98D;
	Wed, 25 Sep 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="M2gohpQ9"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691912D20D;
	Wed, 25 Sep 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256061; cv=none; b=MizN46IHdj8QONzSzfZ+QcL6c5aM9kiOx9MWg5QrpAWGd7V5j27lwDI9lE2T86mD2VHcKGYPzlX6nH8V5XpKuDvCLEVUsIUL0srVuDg0HOoWaveRXkdUM0HCatqlnJ38rH5jMStaR/UNYfZ1eWWlyosCpl6hng1qA+VO/tBinec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256061; c=relaxed/simple;
	bh=GLQEmzeUldeqJOnrn+jDS/3SSB31p2bx6CA57ceNekQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2urC2nwo6N68J7oXhS0Jx+c+BN5UNQSq4IgxdXDOuYi+KbF76UV3BEkmzqJM9Fgppz11vvZON4wepdCZKHp73yxNqwN01yuqE8K5okj9TMSOA89CL8w33bLwOtZpTrmkNsU1nKCEDau3ifnAOArRmqDkVmN+rV/5GtnTKAZnkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=M2gohpQ9; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727256047; x=1727860847; i=markus.elfring@web.de;
	bh=7ZO+rGRPfnEu18KWtOxv2/SZkBWPjem0XQOtV7a7B9o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=M2gohpQ9bsI9CUDg2CmANwZAgK4JVnjYE+BlKgVXYQB1vtGTJqR1cpw1BtihkiQ0
	 8blO33L1fwb5s+SCeoJ5D+rKi8hT7lG0/IJOAEajXXVMVHy7/zpoWDRkHOPwrvsgc
	 RjSVWkuxP7ymtRAhLK1ASkvdWUW78SpgKk2xgm04AMHG2E1Rj/3ij4TAqZpZLmqw+
	 4f3xcazW+ZgpIudwqFrQG0uc8dj3Qz4bX6eCgOiOx5sVFVbI07bfrsabmO8x0xfCs
	 Q9FTIdH9zPiyZ8fPTdBmJuTYFpobFbC093BNJrN37CRdAk64UBcPG4ASVDPCJa3iT
	 ZEpwSDfuLWnWgZ+UGQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qvH-1rymwU2PQr-00yR2z; Wed, 25
 Sep 2024 11:20:47 +0200
Message-ID: <a0c37886-cf9e-4c4c-8ff2-db8735f97cb6@web.de>
Date: Wed, 25 Sep 2024 11:20:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thunderbolt: Use common error handling code in
 update_property_block()
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-usb@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <26b7f215-4f83-413c-9dab-737d790053c0@web.de>
 <20240925084501.GY275077@black.fi.intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240925084501.GY275077@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P5fqCf6lKoodLOQZ9aQjp2tjE3Yh/CkbUfe/mCjFl/F5a38FP+A
 JNzb+ThD7wqavebxnAcd6lhxKQpWCzH1ceAyLWlAhLMX/krkxhIkp4ql/Dkh2BnUXU/2s2b
 zNaHeAFjO5B3DXJ28Anb0HINN+HF+vK2UI/StZl/YvoVHW3WfX4VZCO7OqOnD8sLIOjxBJ4
 W+8Pus8Wm8ueXHstEzPLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DxkKWm1Qn50=;ebEqWwT7nrovll8rugEu7BG6AD3
 BLQm4U8eM5FUaZvnPiviwbQy5bVw8UKas5ynCLgfjUD5GNrAd59yguTlohNsp0kIbv4LAD40O
 dJGYf0hH7O22MxiYkAKfkA8vCBj2FujeR8PQENRa+kgpA1dGRcnZpwwhpHbgxi1iRi1GLtwK3
 Qqie36x/YKrGunwd7H9B1ze1kOprpJAa1B3NooSGN82Tly75k02XxHUcZ/QYtC3OQtKkz2BTd
 vI0IbLWSa+UObqcwJim/XPWhIZiPBKbMD2En+BQM2I1AvKRHC0IqRV/G/8z1GNa/+Jz1cOut/
 0t+eG+q0Y89fGaiiRE6Wflqxyq10k0fnittEazj3jTV5wrs5A58Xqiep/jnUTXxTA75MSkCWV
 Ef+P0NBNsgICWalh4S6EdwMc2F7D9jFNRsUnsuBmX+uhSEVUSorktVqO4MqSn+8XvVvNH3vnX
 BLY860Y2JQ3w08+dryOz/psyDnOzOjt44vGhOIwT0br2fnYaxGokt7rEkeYiUu5p41VebetsY
 E8SWEUqEAuUoyxqz3ZeIyTDuxo9whECXIKbkXHZsIkOCBuKMxBYo2zlTHJ4gPy7oa5l7Pzg+Z
 pYi/YmthehJbUwTeELtbOM7P6oiOCx25PYUvQUWlJX3M6LN7r+fg7RUNEef/r766LgB3R7SS9
 bLoXfg2VMboKkwKrtGCuSb3bDpKHsKGZVQBqFjpG+ZraPlXLCdmYe1U55mIJxrhiqgGWY9gZP
 vCeBCXbSmAvYPUxaIfBRRZQCaOlPho7GsNQKR/kI+5702ghNgVUKCmAtjpbnB3YoKCaD0LchL
 9UblA+Ffk7AS4rbFnqo7lZgA==

>> Add a jump target so that a bit of exception handling can be better reu=
sed
>> at the end of this function implementation.
=E2=80=A6
>> +++ b/drivers/thunderbolt/xdomain.c
>> @@ -670,23 +670,19 @@ static void update_property_block(struct tb_xdoma=
in *xd)
>>  		ret =3D tb_property_format_dir(dir, NULL, 0);
>>  		if (ret < 0) {
>>  			dev_warn(&xd->dev, "local property block creation failed\n");
>> -			tb_property_free_dir(dir);
>> -			goto out_unlock;
>> +			goto out_free_dir;
>>  		}
>>
>>  		block_len =3D ret;
>>  		block =3D kcalloc(block_len, sizeof(*block), GFP_KERNEL);
>> -		if (!block) {
>> -			tb_property_free_dir(dir);
>> -			goto out_unlock;
>> -		}
>> +		if (!block)
>> +			goto out_free_dir;
>>
>>  		ret =3D tb_property_format_dir(dir, block, block_len);
>>  		if (ret) {
>>  			dev_warn(&xd->dev, "property block generation failed\n");
>> -			tb_property_free_dir(dir);
>>  			kfree(block);
>> -			goto out_unlock;
>> +			goto out_free_dir;
>>  		}
>>
>>  		tb_property_free_dir(dir);
>> @@ -701,6 +697,11 @@ static void update_property_block(struct tb_xdomai=
n *xd)
>>  out_unlock:
>>  	mutex_unlock(&xd->lock);
>>  	mutex_unlock(&xdomain_lock);
>> +	return;
>> +
>> +out_free_dir:
>> +	tb_property_free_dir(dir);
>> +	goto out_unlock;
>
> No way, this kind of spaghetti is really hard to follow.

Under which circumstances would you follow advice more from the section
=E2=80=9C7) Centralized exiting of functions=E2=80=9D (according to a well=
-known information source)?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.11#n526

How do you think about to increase the application of scope-based resource=
 management?

Regards,
Markus


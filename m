Return-Path: <linux-kernel+bounces-373431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4495A9A5691
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65C4B2113A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7CB195980;
	Sun, 20 Oct 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KkLQKhjh"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E71940AA;
	Sun, 20 Oct 2024 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729454157; cv=none; b=IP+IumMgR3/FKeaUdR8j4jsUKmwOsKcWcZHCxcHZbHeRz4skQ8pbqFt+NsC2gv3zWXGcc2OpxH8WEp3jJjHn9h3rK8JMmI1l/1U60t1wTYGqc5GIqYOd0PhuceWHpQ9ixYy1H88v3mCXzpcdvApt2xHPUUVjD0JXvaZmy5wwQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729454157; c=relaxed/simple;
	bh=FXqf308rylK9O4GFeiX3DB1IkXEf6PZvHXBte0bh7+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Do0q7xCDabwb2qjzVTJhHorFyplqgkj5i7AGdpoKrG1Kb4qeODTeLWhBmfGOvmaJ5YDYJlNy7CsRbjYxEb8EU1OHW5+aJtUr4t3xXsTjRrgoXD7DK2QXCQLnv+KEcEw23r9jFAiv1XNHNh5pQfqQ3sZ96qPBmY5E3dzCHFLQ05I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KkLQKhjh; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729454098; x=1730058898; i=w_armin@gmx.de;
	bh=CkD6ffDYZbGzmccN5Buj0EgCQkKmUxEuDqItKcf73UY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KkLQKhjh9KfqfnH+jHQCvDaKshtOtdau5fQKPQr3outh2rvT5bb0v1kzbGIg21OA
	 JkUE9t6Ck6sx94ZyIyV68T8KR5LUglzAfQZDwdgkbENrJBCzIapRTFcMDXIpMG181
	 Ah0lyJFm5FAfd5cPrXUfJ4wFnFetDqoHg6bPuYIVBLssbL/qCKnrK41D40tlQDq3I
	 Tmtt5WpeJKI9BWi4/kxE5h/9mH1P2UrDYuYibzF0z71P/hUMgqkEgt7jtErlOJEDM
	 xjwRmqlwGHHLQflBQFQx0UWCtMRPGNEuvux3XTddjh809xipNMGlp6FBh5TRhdXAB
	 4KD+rmNYjptaKSYcZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3se2-1u2F9u1WpE-00uNQl; Sun, 20
 Oct 2024 21:54:58 +0200
Message-ID: <eee71aa0-d0db-48a7-ade9-4b444c087de5@gmx.de>
Date: Sun, 20 Oct 2024 21:54:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 corentin.chary@gmail.com, luke@ljones.dev, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Larabel <Michael@phoronix.com>,
 Casey Bowman <casey.g.bowman@intel.com>
References: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
 <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
 <c5aee6fc77427daca6e009cd22c3637bffec0219.camel@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <c5aee6fc77427daca6e009cd22c3637bffec0219.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FTzClKUffgmllrQpZmABpd2v6uXOCmXcKwnei3cvpVhsyvgQoMn
 vsu3rtpyLfapJ+AZ2UI5T02KYBakxkWg0/vmla8Ua/5bvTRCk0jI47MdSI79FirWFoYQii+
 x12sJLqqzIqlteSQ+em91o70bMF0Fc+Hcplrt6rSFaoV4xOwcY9dFotcB7iziUBeKBhvYY2
 dudYc1lzeY88GygEpGR9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9pyDV7uI3VY=;52y21rdlKBeXUve5xbhqn+S9fwD
 4e0DzYRqb83q+mfB6YMLP3HfA8MBtvIUUYSxYLa7yiH6Gf1Gu63P7tt88LwPo01c9eezshd42
 21wH0NsEsASAxXqQDVNSfmzYGX7OlCBLCqcZTrq+MHJM98dJy7bjkgWaRT0vO2ON9+dFzd1xT
 O5F3b63TaoQM6XGE6PFTkSP0RTmoakfUHfpIq3/MYVzZKZCleQPrA0lDYgvl02uoV5LLtonIY
 nZUyuO8RqMlE/W/Urw9wNHBwOvdMt69aJydnPt6NCKTxm4/ypQCk59ErKgdB735XgTPyiz+7d
 VlUtnawhaSnKhnHd1FGP/uz/BNEK+PWGjcmp7+eWkS09FPhanNTenkxCv5MprZKEz+ri4WzDi
 RSFdf7In0rC97hTR5hOkViXa2Ae58jWRCw5NjHh78dX7bjX/6C0SuwTfOQHebuLjgMOjLYxvI
 dqMJ2ftPWTtFRcaLex25RVTa4wtxXJy/u7es8M10483+8IzgDN/xdcpZ7+ogTn3UGy7ORRr45
 zJZHeuM03bbcq8RYF7lnKIgtkB0J+3R4xRzXjgEKcQCyjVIlzBomM7PwV2N1F6ifYvm51rv1B
 AZvuyOZEP+ygXzJ9cdH35ilq5p2pJ1w2jbBZbgwB/W7Tji0K3kRp5DJ8JNOk94b6Rj3zfoOH5
 0H1uNd21YJEYwCFCdMHHGNt1NmvrUzM+Y86MFczEsQfDWGnDFSTT1Tbog0C7e/Z7PfjuaIYBP
 PrC9VPL9yxWJ5ubzakgmw++F/p4aSV730x+g+T7rAEGvzoDLArvp67ZAu6HtP3hJQUMk5OAWW
 Ln2eI8RFytlPbRqmPy2VryBw==

Am 20.10.24 um 21:27 schrieb srinivas pandruvada:

> [...]
>
>>> +	adev =3D acpi_dev_get_first_match_dev("PNP0C14", "ATK", -1);
>> Is there really no way of changing the AIPT mode through the WMI
>> interface?
>> I would prefer using the WMI interface if available, since the
>> firmware might
>> assume that FANL is only called through the WMI interface.
>>
> I wish the same. Didn't find any. Asus is aware of this change which I
> submitted, they didn't suggest that there is alternative.
>
>> Do you have a acpidump from a affected device?
>>
> Will send you.
>
> Thanks,
> Srinivas

Thanks,

the return value of DSTS() on your device contains:

- 8-bit current AIPT mode
- 8-bit nothing
- 8-bit constant 0x07
- 8-bit constant 0x0a

Maybe you can try to find out more about the unknown constants. For the re=
st, you can use
the helper functions provided by the driver.

Thanks,
Armin Wolf

>> Thanks,
>> Armin Wolf
>>
>>> +	if (adev) {
>>> +		acpi_handle handle =3D acpi_device_handle(adev);
>>> +
>>> +		acpi_dev_put(adev);
>>> +
>>> +		if (!acpi_has_method(handle, "FANL"))
>>> +			return 0;
>>> +
>>> +		asus->acpi_mgmt_handle =3D handle;
>>> +		asus->asus_aipt_present =3D true;
>>> +		dev_info(dev, "ASUS Intelligent Performance
>>> Technology (AIPT) is present\n");
>>> +		/*
>>> +		 * Set the mode corresponding to default Linux
>>> platform power
>>> +		 * profile Balanced
>>> +		 */
>>> +		asus_wmi_write_aipt_mode(asus, AIPT_STANDARD);
>>> +	}
>>> +
>>>  =C2=A0=C2=A0	return 0;
>>>  =C2=A0 }
>>>
>


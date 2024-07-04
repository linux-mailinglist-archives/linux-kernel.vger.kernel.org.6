Return-Path: <linux-kernel+bounces-240999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9C1927586
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4861C2130B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D020A1AD9D1;
	Thu,  4 Jul 2024 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="hoGDsGFh"
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B01AD9EA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720094027; cv=none; b=ifLIZ4PAdi5dKLsIjeUvYMXAzOWK0n/LQ5M05TcOC0UC+BoSJK96SVhfEQxi0y/NQtF1uXvHjyui2RWr8gI3go3qzsn4l0qOx5t+x41psn8nM9cHMbRYCRA2V+FJBdNE55vOy5SH128zT6ERFBcoI/3IZXWVXCdzsikR/r+NTcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720094027; c=relaxed/simple;
	bh=eh3FLln4NGZyYClFo0FJIgNTWuxuqbiWfuDw4ps0rWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ugx9KDENGw3Y0QiHGDwdpzN+GsbnTLYKSroVGuQ+o0QGjWPzb54ZX9v9ywKXK6ND79HPiqo3Wa7dRVwgzKKWprve8B5Kl2TnXAJ8q9mqpKl/UBW5FjlLfVz1I2mDinwhUkfWHFgaDCuvuCrxkt8vW/FhTghsNkjE6icZdKBmeuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=hoGDsGFh; arc=none smtp.client-ip=62.149.158.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id PKyvsCu1uzLFGPKywsI88b; Thu, 04 Jul 2024 13:50:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1720093835; bh=eh3FLln4NGZyYClFo0FJIgNTWuxuqbiWfuDw4ps0rWg=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=hoGDsGFhmHUnjCZVVQ4ey0YbRuqbgT5Iy9BO20KyhXNUGkSvycaUolXCiQL13Qn0p
	 HZu9/WfZV2qe9xdHKdL5gQlxCuL9eQkM1EvGbGm5lWZ2zhGAnkJMWviFNrGz67Gy1Y
	 lW3fIER5mPx8FeU87WtfecOFDEQZuz9lxjTTJUXx1vd6NVVG470lLeBiMqiuj2HSBl
	 ImpA5Le7xW4KijH4UDh361wGdy7lIPKtectL/rB0vX2/Yrft5LF82bLgI3Xj4UdCr5
	 MQuyb4Rk/bjASnI+NG6eg2XVvN5JpATw4ueWhvTRlzdtLWunOzSbd6nsMJymgJvB+l
	 sIaO5M1YWhcQA==
Message-ID: <d463bd28-9890-47a5-97cc-14f96db2db22@enneenne.com>
Date: Thu, 4 Jul 2024 13:50:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/3] Add support for Intel PPS Generator
To: "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "corbet@lwn.net"
 <corbet@lwn.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "Dong, Eddie" <eddie.dong@intel.com>,
 "Hall, Christopher S" <christopher.s.hall@intel.com>,
 "N, Pandith" <pandith.n@intel.com>,
 "Mohan, Subramanian" <subramanian.mohan@intel.com>,
 "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
 <CY8PR11MB736490B761DBA045513AF078C4DD2@CY8PR11MB7364.namprd11.prod.outlook.com>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <CY8PR11MB736490B761DBA045513AF078C4DD2@CY8PR11MB7364.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNw/GJG7NfJC3Orqnad1dvoxIQzjrwIsk9VE1qjl4UZ6wvBCu58y/F8Nbs5D+MPrkMatUItes1REacCg2kySN7vU964GrQFRf3Ds4oacAddn8dR0WU6Z
 0TnrNrrza3FR0uz32kaQNHyphkyH5zmlPOwgTvFu1tQx22eo9PDgAk9vA1hzYkJ0APOT9XQaWsrxQRrl2nn/qJp9+dRAI+beGoxGm6MJqxm4TZ5dX7pWUUI7
 7wCBMT+nmp3ukJaJL7OO/CIfLldVjc0U0uPovhMzNqX5hmKrboz/eL+JP2GtMvTNHJiuTF8Ni9pbW57BXqxrwD/Vs3GxTt5QdjJrqqSocnvP9xAqF71s/9BF
 QrUfDFeyFYunT90v19etPsbPEenieKRZZkol1W8wZeJGnZcuCDqS/8amUwQiLWBvmXNlus0SsMDsKXc+pP4L2MzHGPqzanqrdfkRAaWLa/6TROAd6Y2mawcq
 vTzvMr2ybY6iVRw5PIGQEwcJNhsFPv60HNuMEEiptyAk/zY3GBb8tLd+epgkHqGuDFGoTXlu19NTFeWhPESK/EvfRJDdZw931BhkjJ9xRmc2p/+mgqlcfI3c
 5Vfjhgsd8NNSH2mwVT1B7ZOH

On 03/07/24 16:47, D, Lakshmi Sowjanya wrote:

[sbip]

>> Subject: [PATCH v10 0/3] Add support for Intel PPS Generator
>>
>> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>>
>> The goal of the PPS (Pulse Per Second) hardware/software is to generate a
>> signal from the system on a wire so that some third-party hardware can observe
>> that signal and judge how close the system's time is to another system or piece
>> of hardware.

[snip]

> Hi,
> 
> A gentle reminder for the review of the pps patchset.

I already acked these patchset, didn't I? =8-o

Please let me know if I missed something.

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming



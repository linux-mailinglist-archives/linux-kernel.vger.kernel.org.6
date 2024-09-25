Return-Path: <linux-kernel+bounces-338332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E0985689
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657531C2121F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F06E161902;
	Wed, 25 Sep 2024 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="E8yLEu7F"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93115CD58;
	Wed, 25 Sep 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257222; cv=none; b=BXom9PUiKVcF6nZ8KHyiMlu9v5wHKq4JDYb6w+ACwbxbmseDxj5/e5n5xEv586n75jvDjq6/e96q43PA1Ju6iEnKz49hSj/xA1Y9cBlfTFdcViHvWq9b9MFrdrCMQK4hWFPa1i97j2e3T/yxoneTWvM5E1bv6GEoQPNM5wYCWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257222; c=relaxed/simple;
	bh=9JcTWZqdyUkw9D5W1wOFl5tb0M/8+b45giHbTu/CGIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwxM2pa8T3MYrm8pMqFvWdFg3WGruCQzf9elhADkMZ/eXMUmJeUE+mosdYhbGT+wr/U995oXBCdkbjHbxW0TvMBhKsshpDL69xj2rVjg59J6/EHAk4eZLuK83jbZTJMMgUR8l4ZKW2OXr9s8VeuS/j0i3LXXtynsd1aZUFTSEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=E8yLEu7F; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727257211; x=1727862011; i=markus.elfring@web.de;
	bh=JflRnbTAwwYWL3y5oWx7wGiYjsQVpc/xMlKSLBk/HRc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E8yLEu7FU8+2tDJqD/EKZjQHi/Vb5oGkoEiDBGi/P3zkiAoj/ihG810MP1W+UACd
	 Zda4Bod+epcva02wFn0vm06yC63CcyKFaskwbKs6NzibixyEMuMWSGYeHdGyrLjlv
	 rXhPu09zzISd20qq2/g21NCkkQHJ9Sh2Dvx/nNaP9GDfv5NIZ/4o98MmbUE0GV4zO
	 0dUfMKPBg6uTxznD3hug3/RELi9E9uCptBE2QL64m14jDXyfM/RgpUy5Fwb+6fF8q
	 gkAUWMZuvTKw8yLH318sdphOZaueOIA8hLXyEOBFlXAl0PUgpO4kKXPTCiLFaDJrx
	 PMkh06yRG58DeXCclQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MY5bT-1sRZ8Y2oaD-00Jwv9; Wed, 25
 Sep 2024 11:40:11 +0200
Message-ID: <10630d7d-9cea-40e1-8140-eb79c06f5c0f@web.de>
Date: Wed, 25 Sep 2024 11:40:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: thunderbolt: Use common error handling code in
 update_property_block()
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-usb@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <26b7f215-4f83-413c-9dab-737d790053c0@web.de>
 <20240925084501.GY275077@black.fi.intel.com>
 <a0c37886-cf9e-4c4c-8ff2-db8735f97cb6@web.de>
 <20240925093538.GZ275077@black.fi.intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240925093538.GZ275077@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BpApNrneg0PqqKe8Lfpr90/NbtkrYAXQvlKdrz/EXBTzCMG7zsV
 gNERbm/xgFT9pnfUyJ7IE4/M3G+cuXsHA7gnyGrX8uFOIuA3WnGgTxEV+MBVrKUkReALkMD
 mUROheayjo0eYaZnZR8qwq/zVC4q51rEpopmkhlP0HK1ZhukISNADq32Se9M8WO94daWbcT
 /Y+edDcnykb1oI7fZah/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WWIKu+TKs7Q=;d0hkRn2emdyj2FjcdS52EL4fYeo
 ef8cCvlqbEvuRoLjTX6hf/i+U6TpfGzjC8odzDKaCWfprDKZUFeSgwOgUkejlIhQwZFI4SIYJ
 M+JGQlQQeLnEOUDufVZQzKxYfVt5J85lcl1CiBJkjGOr5rQU3wHbDM2nJIhSk7qtLEccZbOIz
 NvvP76cHPr4lCAxKjNf8bKvqgr46iELtJ8AyQNqrNNwZevy3lVieI9XqxX/obO5JZsuKiDPR3
 kHuqAk1/rEvvf7wnSOy9dy/FN2071+35TaijMa5atRXmYtTt1YOBnEozLNzKEwIfHNr+o+ts6
 MV5ZH/2vEdAXPLVM7gdxpzHifpa7HYS9+kuwCxuWwPwakpMq3w9usb9UwvGZDlEYa8A5qeqcQ
 13FYB/U0vNeCqNi2xWv/ddfkwlZ7j4ceN5L9K6DdWRaWtozlYLkNoMVsZJu9+mRyV012rZYKW
 72Ai+5EtKzhgOtoq/pVjGJervuDgTjkKrkGDE6q0ZxfMdZDSPMomTCzLfJIzB61jGQIeLMPfM
 mJ3+o598xaXvFkYkfYlaKExkiBlJZmXxgWgNOLfzuWi4D/sig1GBMN8nmeLkGLw9ietWOwgBH
 vNWDI6r1L0+/cVOZR7Rq/XTO2f4l0XRMB9twgsVDyEdXjeM8bjti5t9ZBF1v0E3f5aaXi9wr7
 V87Pp6uiX0IeD98NTOEY+L0Q91XGbPI4q9fSVxBTjHadD85mALonCoTjfneEjPW6Sl1OV0ftm
 woUpjPwWm6bmMqVEUc5cl4ggAo+8WPSDSm5r3P92TI4XbnlJJJyfrdlBWT3896JSD0mB9l3xQ
 DyqXwWvo76WP3qFRKbAPfAfA==

> It is fine to use goto as it is described in the document you linked but
> this what you are doing is certainly not fine, at least in the code I'm
> maintaining:
>
> out_unlock:
>  	mutex_unlock(&xd->lock);
>   	mutex_unlock(&xdomain_lock);
> 	return;
>
> out_free_dir:
> 	tb_property_free_dir(dir);
> 	goto out_unlock;
>
> This "goto out_unlock" adds another goto to upwards which makes it
> really hard to follow because the flow is not anymore just downwards.

Would you like to benefit any more from the application of
scope-based resource management?

Regards,
Markus


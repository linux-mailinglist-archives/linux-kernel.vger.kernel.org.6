Return-Path: <linux-kernel+bounces-545853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A108A4F2A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897E63A8D92
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0717BA1;
	Wed,  5 Mar 2025 00:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ntmvQCBD"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6254C92;
	Wed,  5 Mar 2025 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134246; cv=none; b=L029BYS0BJX59WvzPC7qvHb6mFfpVgt6P4h4am0myIOJKxeoHo6Wk4TxI//4OAApabwIVxSzTmFG4hmluxJGHjY9xlxlJ3tJDEO+ud0xDPaBjyZ5NI3OiM1Lj4e6vAm+M6nRe/6MFxsUIpQWfNQNlOBSFUxFAGDEyUk45PKH2Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134246; c=relaxed/simple;
	bh=ZffagwhXynQL6/ZJWEi/SCLVfqEhgHkX95OdObrxGPo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B1u0PqClFptZwnOIso0YI3HDQ+JZekk7UkQzjNWZciOAumOHnKeDJViH6TeL+DQ00wBdFVvI75YBTIxA0GR0b0kqnzV3u3gTdQiC0/PcbCbw5aAaTLRY6I5yToD+o1ELb6oPf/EFINJUCQmKcwTbmqMh8e3v4EiRPcRxuzFwahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ntmvQCBD; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741134242; x=1741739042; i=w_armin@gmx.de;
	bh=bkebOTkBt0tpMwOpl8zGoATCutFsP0fWm/l3ds4ORmE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ntmvQCBDQwXUcEhV8RJ8Vg6KRt1wDS2rvldQ8erbbG8/Q9C8iyENnXn3NXsyLN/K
	 Z1j/N5ght4UrLYhFGE9/W/OGSMFovlCTdLdBp0S46CeU92krgM71J0WhUZRwHnRv0
	 cQspGktqGx8CCdtmEJHvkk2yZ3zQsr6Y9clVc9NJY729T2cBVMHno9AgZCef1iwgg
	 cJQIALnf4xTWJUpNI7l/6w3SuWJ/LxUyR94865DW0Cwuw2g67kXYsFVTy3yD97B7z
	 kPwrj9hQyw8pllIWWNXCR9+HwsmmWcrLFwsD0qfEsHIaRr9tIDRMOwptiPhjf+gzK
	 01NuxF77Hi/0HPtr6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oBr-1t1lYq3pTR-00v9yw; Wed, 05
 Mar 2025 01:24:02 +0100
Message-ID: <f5d8b82d-c711-4611-b257-b4297f172bb1@gmx.de>
Date: Wed, 5 Mar 2025 01:23:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] platform/x86: acer-wmi: Add fan control
 support
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com, basak.sb2006@gmail.com, rayanmargham4@gmail.com
Cc: kuurtb@gmail.com, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250215174544.8790-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20250215174544.8790-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:olaVtLE52dszs6MJvjxGkPlezg1P4YlNkVCuIGoGiVk5q4gnlZ3
 zJL0uBkpqW9gm0z6WUo3fiynl61hvPJztviqoVLut2PIJN8361QDIMVc74dtjgxSVRMF2G5
 /luz9MJ7HKTcNNEFilKybEsYMZ5MI1B/4oiaBp4rtEQDCAK1/tm3DHLHphS9ODBwy9L+H2l
 XyZ6d4sRrhb3lYnE5J8iA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JUwDkcbxucM=;cIhnAOBIlUHnQZw656v1wlXOmVy
 8n69MuG7BsFgfQ/SvMWC4bQ10eqbktFtnfFDAF963XI7Jx1X/EB1SHlK6rxl2aXSIzQc0Hp/Y
 1aJlFtyWuQJQRkcbbW4/oq8Cef1Q3CfOH1ibjaaOEFLuCA16ag8y9XSKkw3MNENuir57HthUi
 ALUx+bLeI0I6gyrV+ikz9v66MLP9O7V4rmLLPoh90qNNbFYGrmuAsyDjq8EEsDkxXYa44brAp
 WB8vEVtEXbZS9qcH1w7rCBeinNs5KH9TxxIc7lFNDRmYXb4qAgvTEv4PSTiqNCQvY3Aw1TO10
 QtXatK/yELdftjgF9KqWfqYZVWkI9DmJYVDXsozr0vbuCfmIikoR3oz85Y1x8kXX/FTD+vcg2
 rM+QyftcDDbBUuhRYuJkS0Qn82AfNIv0CaZ0EBdhoTxIYLHYsa4l3U8Ifp8YY5WvZTKbsBoqs
 szUrFIUBx6ABXKn2DLukWzmwF4MDWJ1VjIgdG6nj9Nmu4VtnEfSNP4qXffblx3XFWP2mosoW/
 VeIU3A8jyYs2paWbtqaytX+DePTiDiM9plZK1S59vWSbU5hTi3m80UGv2wD87z56scfg4v3lg
 7bcAixWgVqnxG6jGF5eYs1ZEP8D12LRd4vXyXR1td9OmlGctPpna+131PMeDEZjD7QsX8i5FE
 tvhcA0H58xFEWi8J/t36ZCtH86XM4nJCPX98HwsTImU+/ARi2wGaWixR5JKdaHLTeOBpQ4bSH
 8B55yTaKZysx+MdPyUZUGykVLaD70swaiwXUJVqFW5he3RoGtKeVaa6rz9SAXCOeoxnr0Z6BL
 gUUJXiSNKKXd47+0wctgqMse/XucDIjkyX6QwMThyk4pls0mWPVBmZyj5v0zAqiZ6KMisibyi
 JiozlROCKWUq97CfUf0Y24s96gbeobNDhxezkvAHYqdn4XnYrODoe7Ex1hqAiDUlNgKwiIVVQ
 +pHmqSBM2MNUuQruYMNbQcOxAN6Hl9cyzC2TtI3d8/X9VLB9RI+r10hsXBy1azgV82c4/ySWd
 s4MoAoj/Piob8SjrGOGK10tQq0p8E7vRzIFyqjTNieGi96Grq79y74d98CuW3J1recCzj99bq
 vFrUPiJHY/z3TDqx6a/BUrcl0tduPAPfrthKODvfHXJjGpGnnzeHk4C6dVIhXmrBByY3kNVLF
 Wn1/5Z0KLCw5sQNuck2XmobltQawwtuMG/WXZei3fZpdzjRpI0VUWSxN0j8qvqOmn07f73oG6
 s8CdC0bshMRGsM4D1j2ITWw8cvkX+tdKF4QVxDOF+hly5cdgKQjYp8JePsdLMuABt+knLl/k8
 FJQ2Slyh4rMQ4BGTlxlatCuRI3wfrpkuLJTUJqqHuIAf5DjGqzm0NKZbv3N9M0UaZZLqSG+Zp
 F7MIzwy2XKXa3OfRMjWuzfpTM5MPUU69jIPUnbrhgPQyCBdwwAl63owBB4

Am 15.02.25 um 18:45 schrieb Armin Wolf:

> This experimental patch series aims to add fan control support to the
> acer-wmi driver. The patches are compile-tested only and need to be
> tested on real hardware to verify that they actually work.
>
> I CCed two users who requested support for this feature. I would be
> very happy if both of you could test those patches and report back.
>
> I am ready to help you both with compiling a custom linux kernel for
> testing this series.

Any updates from the two people with Acer hardware?

Thanks,
Armin Wolf

> Changes since v2:
> - remove duplicate include and replace hwmon_pwm_mode with
>    hwmon_pwm_enable in second patch
>
> Armin Wolf (3):
>    platform/x86: acer-wmi: Fix setting of fan behavior
>    platform/x86: acer-wmi: Add fan control support
>    platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
>
>   drivers/platform/x86/acer-wmi.c | 298 +++++++++++++++++++++++++++++---
>   1 file changed, 273 insertions(+), 25 deletions(-)
>
> --
> 2.39.5
>
>


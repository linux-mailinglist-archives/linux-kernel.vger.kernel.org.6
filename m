Return-Path: <linux-kernel+bounces-436234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D79E82F5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 01:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179FC18838EB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 00:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770D8493;
	Sun,  8 Dec 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="P/4fSrGk"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B78118035;
	Sun,  8 Dec 2024 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733618172; cv=none; b=elfg45D1ITIYGDZN0beDiFT7LKd43qluujqhCWKGILPge9vdaDgndA2Z4/fiznfH1a7s9vR+1kk4uCSAKjWw8XNZxolF2NU5XcF0spCDXA+n2Im6U6qJlf09sOSvnjiJifV9KqmDVj+TizcjcKOkZ6MUWhqqAXzYc6LdSB36cR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733618172; c=relaxed/simple;
	bh=PaN1CMHfi/mE94nKaZXHJ/LjnzYwtLEXcURjOsdp+ok=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=R40ZshW4EOIw4VA4ggnalKiz6VFaI4nCzsrbml23y5vv3NMLEyrRWk7Jye8L9DP9kzenBtPaDCrq0CVL0s/ef0D+A/wkQQgHGlhSxesXahIsx1w+ORxdRtlQiEGjudJWSW2vW1Tzbr6pRxHq4SZ4wiFcJ609FnMY7w1IcpVSFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=P/4fSrGk; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733618160; x=1734222960; i=w_armin@gmx.de;
	bh=GRwdT4pWZL6KXL583qwCFEKU2VG67kSzO1j7SGkaU9I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P/4fSrGkWw+QtMz2lMP0QNWAZt81k/j1WDPUqa/XanSQMfxsImjUEj8gzMSh0aFH
	 a9SzAfgqUcqYSgEE27h+2mELi9EcmGG4zjKLpJTXPtgxTQeVQT/TMVyjrONtsCDx5
	 qtSdSk6w1PeYESrwYJlJge0cXiNcX44mikxG4PLhjDfKfGp4m7UVWjJHGxvrCtJVd
	 QY2hwfqPPB4gKT8p8d7Ai5VceRC8r0+6mp1z5+czEc5EWZQUe271y/MPGJRbC5eI/
	 yUZE5IcjNnHlqRnkokkCXM2J+sUHyKz59pzS4gl6skTyyFfWPg3o2q8RojTfCkyCu
	 tNtPN++kyf53aYp6sA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1tXv3z0Wt1-0169rZ; Sun, 08
 Dec 2024 01:36:00 +0100
Message-ID: <6641ef91-7d07-4104-a31b-e44a80952444@gmx.de>
Date: Sun, 8 Dec 2024 01:35:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] platform/x86: acer-wmi: Various improvements
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241129193359.8392-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20241129193359.8392-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EoOkpN8Jhb9Cyznt2e4cWuwLb8PQnqVwMzUhYu2wGJ2s/I+bOLm
 s7CThJeEAOSX+Vas8Io3N46OXSwVh30/s10FJIfAhOOPlDCuwLXyKV7gtC3fl76/yaeqVeJ
 4HVqfyl7YKFRKTpdwD0PtwUj3eFRbSID2cCgh/WcFhS0gSm5N/SDrQKljMnn3htD7BGYsdx
 VeH/R/H7QEAGSHu2KwxAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q3DgEE5eTts=;yrPoLw0gd0d9azB8hZ1q5k1ImeJ
 HRMziCYJbOheMFLIa24z+wJSGmnJud6NrIv/Fzvy1s6ujLRYHnRnZe/tkl5jt4YlhXXXJxhLM
 WGuf7dK7DgArKX/+hFVnK+tBqmSvbZ4dp65Ip0Do3xuTWgyUNT3yaKGc8sguPr6P6jn0xziuA
 Wkl+GCbxHOZoclu4oocedYQOi38j1pIEUIrYevDMq2fo7I2BX3gPXu5JjrJVZ4cTZXw4ZoSSB
 MFJh751vOgUJpEzYqwwaz84WXnittn/nWD23TCgxj56tPOzro0j0mJU/VHaPRQw0jSTTDnTgk
 Tk9OaHQsEogqrz+uOdGMOouUX4IvbKsdEOnee8GWEwpCPrAoqV19kcT6uM3d8xtv7q1OAx6Vf
 CmKq+I2Txx5eooj50RciKqwwQmcUWsUbsGpWKFszXOHljTLVxx15CwSS/+9G7mI8DAKND5yVM
 ivGYvG61pkNob0aAFDrlzVN6n+vYroBRadkF/LIvn7HHcqlXlyhEYXxLy+eNB04KWssxh08fc
 OIB1zoddsUK3u+ykK4p8tPqDfZyquWnPkf6a1p6VaWu+VayeZ2u8A4DwLl+PPjW+M1Edw8hCq
 9qu2H9xGIOnKKtR62GIZBX2ciTVKnZR1qaUyNnANre4pRLEsNy6mexOTN2syqsFmJovxUw98d
 1jbqexBbAO2UXm62Xp2m/m5I0kTqRTv+L9qLOt7qrgslaJ9SJXTsHFi5yE852TJhdRmWB+ufD
 UIF5Mb+G6HGruqH3KlBVLTAxBmO8kYnRUg7VgaXas75QVKiHqK0mYsVu2qDqK8kgz/nDMNCd8
 hFNXph1f9K+mzHibQx3phrH6bTjWhSX/xTRZHEAXm1wARvtILJLr68LX0GQ18CWhrMdm48rEM
 6vLywUrVn/DM37NILM66uUm9MY2n1x2m8MJ53HIn5fyQcHsOzd/tlcvZKtDxyed18HECQ83HC
 a4mbUs++9Z/88066e724tEcxrViaDbwtAbvoUAk0FBfL/4jr5uhkCW/unxGDvD7QX2P8HKy3U
 gtpMGWAhsCOsut2hlJ3YHuMSZteIJEDyP3zpsxrHkQzTzqhQKBJl8FEKf0PCVbjIeV6LKdq3d
 yRGuwAtOqAkuzIVLFGtpsYW1xMcqiC

Am 29.11.24 um 20:33 schrieb Armin Wolf:

> This patch series contains various improvements to the acer-wmi
> driver based on user reports:
>
> - adds support for the Acer PH14-51
> - improves hwmon support
> - ignores function 8 events
>
> The changes are compile-tested only, so i would like to have them
> tested on a real machine.

The whole patch series was tested by a user, so for all patches:

Tested-by: Rayan Margham <rayanmargham4@gmail.com>

> Changes since v2:
> - fix compilation error after patch 3
> - replace GENMASK() with GENMASK_ULL() and adjust bit numbers
>
> Changes since v1:
> - fix spelling issue in patch 2
> - rework patch 3 and 4
> - add Reviewed-by tag to patch 5
>
> Armin Wolf (5):
>    platform/x86: acer-wmi: Add support for Acer PH14-51
>    platform/x86: acer-wmi: Rename ACER_CAP_FAN_SPEED_READ
>    platform/x86: acer-wmi: Improve error handling when reading gaming
>      system information
>    platform/x86: acer-wmi: Implement proper hwmon support
>    platform/x86: acer-wmi: Ignore AC events
>
>   drivers/platform/x86/acer-wmi.c | 167 ++++++++++++++++++++++++--------
>   1 file changed, 125 insertions(+), 42 deletions(-)
>
> --
> 2.39.5
>
>


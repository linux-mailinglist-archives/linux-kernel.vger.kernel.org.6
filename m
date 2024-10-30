Return-Path: <linux-kernel+bounces-389441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599389B6D28
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CC0281FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A71D0DF6;
	Wed, 30 Oct 2024 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QkeR0ho0"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF61D0400;
	Wed, 30 Oct 2024 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318089; cv=none; b=WJk478GE32GkZCJT1ReJoLRfdTMG4lwCfW5wKuHq7JtM9MbpG27ljwws6jd5VHYa1FdgzPogZ2uHn6/K58umQEJ9q4FzFubASnVkui6bajvx14pRpxiBsMlRMaPQfrnXIym4bqRi8uHXl4cIQ1LrBHWSCTRMMC44L7auN/UZ+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318089; c=relaxed/simple;
	bh=7CUkA23AZPCfTzQLS3Bz9YTLbnWwqRi1mw79plUJKN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbBEVHp/AH+b4+FRgPQlwSBuQSiF8m9Lyv5i6HkQZwp7FoKXIJ7qKUsjrlVf4rLobm9zA1nInHQl3zwuXRg5FSC6btxuvr9Aqt7F4AGp1kqlHg7dtsEH4s9TDvJQXlLnLV8VxHWAES90eyQ+OWwtZMntHVa0jXjMMd+H1pC+WQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=QkeR0ho0; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730318078; x=1730922878; i=w_armin@gmx.de;
	bh=PFU4SjWjbeevuteMXAX7h8kGOiLDJRs3Rl+fjuBo1lo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QkeR0ho0T7lnVRmiPyAiwbt2FQ3N9z+ujW8qeHjezFFANVWA4QdJhA+GahO83VBd
	 uaoD1ObO7u3YuzsH9oKCX2bY15KTgJGLnw4tJZwHtEpP77q93aBT0TZCDSa1l+Orb
	 wm0He3fz/nks9V2ebYZ9zEdrNMCx1Vo6w53iP/bcEh7sJ1s8VyGJXJjwxHfEYDcv1
	 KzpTZAPRD0x2POcNVRyXPFc/G6xo9CREBkruz5gi/jSjd+3dPJfxQqhoXSlN22EcR
	 b5WnXBxGQaprbT+D7P8v9ElHCGfkJJ1PQyF6qkzJkCWsPdUxYDGCNks/zEg+X3oEe
	 mCrw7WE14FaTw/z0Tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59GG-1t7Khe2RRU-00Ef64; Wed, 30
 Oct 2024 20:54:38 +0100
Message-ID: <2e9fb24e-9652-4087-963e-cbcf3b1f2c56@gmx.de>
Date: Wed, 30 Oct 2024 20:54:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/5] Dell AWCC platform_profile support
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Kurt Borja <kuurtb@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org
References: <20241030000904.7205-2-kuurtb@gmail.com>
 <f972eabf-58b5-3b0b-ea5f-930894ac840b@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <f972eabf-58b5-3b0b-ea5f-930894ac840b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:no9bA3ayeFNTSPO9XwDKymQHeenkCSlqtO5L2CbjrilBQbVo8pR
 6AmSFa2uOBKsu8PRKkQXRn0rmzZFnIYXkSjjDDt0mPo+Kdh6fJsnGPEgNw4aa8u6v0rjo3k
 fR6tH2TpWJqo2IyyRNFkq3iyvR/PZwjErAMPczuaIe6QerEb8meKIjTAX0WvUT4WUjhKBPY
 YYaBCL9hBnCoZlXbNWgtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Yh1ULmK6Fr8=;13G6yfm09gslF39xt/AenmZwkYA
 ZUSrUWw9yqYnDrE9LxhkHgwW7vaX/jxFgYNCzb8uaBGuPgZRmmw0s78QqJsaiEEIZVvqATOHB
 oRV9jHE7G/H8q3f8CshBHyDNlLmf0yuqc2FQC4fPW17atwENLakuDFXRRWlSr2uhe04bDTOeR
 JQ2GXX7oK8J4C/jlXZRUntFvnPVjpG4GEuNTGITQf/D0+Eqrcx8TDEIq0sXUtg2oxqV3IKZpJ
 dXCHy+WGNJbmr/Opz9ThTT4Cqfl4WNZ+mg1SmOmx1ktpDtvLqQ46E6cfpLhlRMKxHJhQVCgbj
 odjz5vBWqeMakhoTUk6UHRkw4iwaDDhFkgCSJBybzx6+XZNcIyfYwGvhiQezsKEq2vcRubG+5
 2k6xompdAD31Ja4/6FpHw49V1z0CwPk4xn4gCFv2Rtre2q8MJWVaHLbOQ591vgyBh5YXOWg+l
 m6HH5U02ueTcI688rVwKZqA2QoqxWmP1ky+AGQOx4ExIb+D7Yw2WV/pchTs+pFQfjvgio6Wdm
 gADIWvlUvHiMFdyt+c8DsD+GDOe/QnU5eOANijpEewT03QcJt1PobDuc8sU7jFF8pb6+GOzsA
 Rhhm9xuahgz5C32sx2HipLc/Wlq6XQi4Xri2Ho4vdnhYqlW0y/PEBO6X83/Mg/A587WJOA3qE
 Ps66tpJ7QvmwV2WBgFZIS6pEMC4ya+DFtOz3rugBrjXiIJ/7RHgeK063vVwXDvbb+GEHmNYZR
 X5OVTX+Z01J5NMLWlhElsqjgLOXIRBG22lx15xiPJ2JM9EzSEYjkexI71tfzkr3pW5gyQ6tRS
 3qSaQBgwMkI+59zGe9OqT1Qg==

Am 30.10.24 um 13:10 schrieb Ilpo J=C3=A4rvinen:

> On Tue, 29 Oct 2024, Kurt Borja wrote:
>
>> This patch adds platform_profile support for Dell devices which impleme=
nt
>> WMAX thermal interface, that are meant to be controlled by Alienware Co=
mmand
>> Center (AWCC). These devices may include newer Alienware M-Series, Alie=
nware
>> X-Series and Dell's G-Series.
>>
>> Tested on an Alienware x15 R1.
>> ---
>> v11:
>>   - Minor changes on patch 4/5
>> v10:
>>   - `thermal` and `gmode` quirks are now manually selected because some
>>     models with the WMAX interface don't have the necessary thermal
>>     methods.
>>   - Added force_platform_profile and force_gmode patch for a better use=
r
>>     experience
>> v9:
>>   - Minor changes on patch 3/4
>> v8:
>>   - Aesthetic and readibility fixes on patch 3/4
>>   - Better commit message for patch 3/4
>> v7:
>>   - Platform profile implementation refactored in order to efficently
>>     autodetect available thermal profiles
>>   - Added GameShiftStatus method to documentation
>>   - Implemented GameShiftStatus switch for devices that support it
>> v6:
>>   - Removed quirk thermal_ustt.
>>   - Now quirk thermal can take canonical thermal profile _tables_ defin=
ed
>>     in enum WMAX_THERMAL_TABLES
>>   - Added autodetect_thermal_profile
>>   - Proper removal of thermal profile
>> v5:
>>   - Better commit messages
>>   - insize renamed to in_size in alienware_wmax_command() to match othe=
r
>>     arguments.
>>   - Kudos in documentation now at the end of the file
>> v4:
>>   - Fixed indentation on previous code
>>   - Removed unnecessary (acpi_size) and (u32 *) casts
>>   - Return -EIO on ACPI_FAILURE
>>   - Appropiate prefixes given to macros
>>   - 0xFFFFFFFF named WMAX_FAILURE_CODE
>>   - Added support for a new set of thermal codes. Old ones now have UST=
T
>>     in their names
>>   - A new quirk has been added to differantiate between the two sets.
>>     thermal and thermal_ustt are mutually exclusive
>>   - Added documentation for WMAX interface
>> v3:
>>   - Removed extra empty line
>>   - 0x0B named WMAX_ARG_GET_CURRENT_PROF
>>   - Removed casts to the same type on functions added in this patch
>>   - Thermal profile to WMAX argument is now an static function and make=
s
>>     use of in-built kernel macros
>>   - Platform profile is now removed only if it was created first
>>   - create_platform_profile is now create_thermal_profile to avoid
>>     confusion
>>   - profile_get and profile_set functions renamed too to match the abov=
e
>> v2:
>>   - Moved functionality to alienware-wmi driver
>>   - Added thermal and gmode quirks to add support based on dmi match
>>   - Performance profile is now GMODE for devices that support it
>>   - alienware_wmax_command now is insize agnostic to support new therma=
l
>>     methods
>>
>> Kurt Borja (5):
>>    alienware-wmi: fixed indentation and clean up
>>    alienware-wmi: alienware_wmax_command() is now input size agnostic
>>    alienware-wmi: added platform profile support
>>    alienware-wmi: added force module parameters
>>    alienware-wmi: WMAX interface documentation
>>
>>   Documentation/wmi/devices/alienware-wmi.rst | 388 ++++++++++++++++
>>   MAINTAINERS                                 |   1 +
>>   drivers/platform/x86/dell/Kconfig           |   1 +
>>   drivers/platform/x86/dell/alienware-wmi.c   | 477 ++++++++++++++++---=
-
>>   4 files changed, 791 insertions(+), 76 deletions(-)
>>   create mode 100644 Documentation/wmi/devices/alienware-wmi.rst
> Huge thanks to you both Kurt and Armin for all the work done to improve
> this series! :-)
>
> I've applied this series to the review-ilpo branch now.

Nice.

Would it be possible to apply a small fixup to patch 4?
Because pr_warn("force_gmode requieres platform profile support") seems to=
 be missing a newline.

Thanks,
Armin Wolf



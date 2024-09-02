Return-Path: <linux-kernel+bounces-310766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8159680F9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B511C21FBE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D25A178388;
	Mon,  2 Sep 2024 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="gwQ+kXdp"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6314900E;
	Mon,  2 Sep 2024 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263593; cv=none; b=AVVKzAm3IPMqHh/0MsaJBxnKKJqJfsQaOR+8tdHzBRJOJaSKTeXwcKKlYV/sF3rE5UrBWVjKWYJ2ksOgRwKX2dPmWSI335eb38+mBcEv7G007MZx0Uc3Uvv31gwbQptNKDK9BTayySr4fofVHtvTOHde+BOwNC1vsHMOeZ/g7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263593; c=relaxed/simple;
	bh=jgsZYlTQdATRaDgliWYQJCkQ3Kk3J3OmBNJ3kUXZ7W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jw2QSv9+K43BjYxCnuWXIVEyOy5j15Fq3Gmb5wyi8gORbfDkcIOPKnZo/r+obqzsjFFoZmLBVaCCqKGc12VnX5A5XgoPDO/9giN3RzAN7k29AYyzcn4gVqr0iR637xNj9aLLkUdTqZb/XofOkmR0liOUGLE3e89HZiZIV4RMcNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=gwQ+kXdp; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 99A8443F55;
	Mon,  2 Sep 2024 07:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1725263586;
	bh=jgsZYlTQdATRaDgliWYQJCkQ3Kk3J3OmBNJ3kUXZ7W8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gwQ+kXdpGLYSFoBu57hqOyEyDXCWTqTCpOyj2fwjlI7YsPurQQ+LnPwHvmDBGPTvi
	 blHqglsvw929z4JyJdU+hhN4DxwmVNv1QS4nKSdhB0mlS0SoTyLqOmAx/aNXfpfdcC
	 HVFPZXnouuT6KoIq1ly0yyRAGlTAygFFe/eepVS8yAvx3grIPa4mMOSNQzdCUq4BIb
	 bAI5m1Q9Ki58vIEsTL9cNP6Jpdldc+g+X42UMtFpcRq+7jnmoI4jiC7BHaeJyw/lsF
	 S0BBBD8XkhQ3EEgdO+FRS7Rd0bLgCaSXd9eLizRJee0N0C83Uz8dqbKr3G6mo/fIav
	 e7KD8XGIKHF8w==
Message-ID: <e9b208f8-6dee-4b17-b63b-64b67eee1c93@asahilina.net>
Date: Mon, 2 Sep 2024 16:53:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ALSA: usb-audio: Add mixer quirk for RME Digiface USB
To: kernel test robot <lkp@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 "Geoffrey D. Bennett" <g@b4.vu>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Mark Hills <mark@xwax.org>, Arun Raghavan <arun@arunraghavan.net>,
 Cyan Nyan <cyan.vtb@gmail.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240902-rme-digiface-v1-2-6e88472a2744@asahilina.net>
 <202409021549.DbXWdqGa-lkp@intel.com>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <202409021549.DbXWdqGa-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/24 4:29 PM, kernel test robot wrote:
> Hi Asahi,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 8400291e289ee6b2bf9779ff1c83a291501f017b]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Asahi-Lina/ALSA-usb-audio-Add-quirk-for-RME-Digiface-USB/20240902-054004
> base:   8400291e289ee6b2bf9779ff1c83a291501f017b
> patch link:    https://lore.kernel.org/r/20240902-rme-digiface-v1-2-6e88472a2744%40asahilina.net
> patch subject: [PATCH 2/2] ALSA: usb-audio: Add mixer quirk for RME Digiface USB
> config: mips-mtx1_defconfig (https://download.01.org/0day-ci/archive/20240902/202409021549.DbXWdqGa-lkp@intel.com/config)
> compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240902/202409021549.DbXWdqGa-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409021549.DbXWdqGa-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> sound/usb/mixer_quirks.c:3000:42: warning: shift count >= width of type [-Wshift-count-overflow]
>            bool invert = kcontrol->private_value & RME_DIGIFACE_INVERT;
>                                                    ^~~~~~~~~~~~~~~~~~~
>    sound/usb/mixer_quirks.c:2948:29: note: expanded from macro 'RME_DIGIFACE_INVERT'
>    #define RME_DIGIFACE_INVERT BIT(32)

Oops, this was supposed to be BIT(31). I'll fix it for v2.

>                                ^~~~~~~
>    include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
>    #define BIT(nr)                 (UL(1) << (nr))
>                                           ^  ~~~~
>    sound/usb/mixer_quirks.c:3063:42: warning: shift count >= width of type [-Wshift-count-overflow]
>            bool invert = kcontrol->private_value & RME_DIGIFACE_INVERT;
>                                                    ^~~~~~~~~~~~~~~~~~~
>    sound/usb/mixer_quirks.c:2948:29: note: expanded from macro 'RME_DIGIFACE_INVERT'
>    #define RME_DIGIFACE_INVERT BIT(32)
>                                ^~~~~~~
>    include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
>    #define BIT(nr)                 (UL(1) << (nr))
>                                           ^  ~~~~
>    sound/usb/mixer_quirks.c:3160:4: warning: shift count >= width of type [-Wshift-count-overflow]
>                            RME_DIGIFACE_INVERT,
>                            ^~~~~~~~~~~~~~~~~~~
>    sound/usb/mixer_quirks.c:2948:29: note: expanded from macro 'RME_DIGIFACE_INVERT'
>    #define RME_DIGIFACE_INVERT BIT(32)
>                                ^~~~~~~
>    include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
>    #define BIT(nr)                 (UL(1) << (nr))
>                                           ^  ~~~~
>    sound/usb/mixer_quirks.c:3185:4: warning: shift count >= width of type [-Wshift-count-overflow]
>                            RME_DIGIFACE_INVERT,
>                            ^~~~~~~~~~~~~~~~~~~
>    sound/usb/mixer_quirks.c:2948:29: note: expanded from macro 'RME_DIGIFACE_INVERT'
>    #define RME_DIGIFACE_INVERT BIT(32)
>                                ^~~~~~~
>    include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
>    #define BIT(nr)                 (UL(1) << (nr))
>                                           ^  ~~~~
>    sound/usb/mixer_quirks.c:3210:4: warning: shift count >= width of type [-Wshift-count-overflow]
>                            RME_DIGIFACE_INVERT,
>                            ^~~~~~~~~~~~~~~~~~~
>    sound/usb/mixer_quirks.c:2948:29: note: expanded from macro 'RME_DIGIFACE_INVERT'
>    #define RME_DIGIFACE_INVERT BIT(32)
>                                ^~~~~~~
>    include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
>    #define BIT(nr)                 (UL(1) << (nr))
>                                           ^  ~~~~
>    sound/usb/mixer_quirks.c:3235:4: warning: shift count >= width of type [-Wshift-count-overflow]
>                            RME_DIGIFACE_INVERT,
>                            ^~~~~~~~~~~~~~~~~~~
>    sound/usb/mixer_quirks.c:2948:29: note: expanded from macro 'RME_DIGIFACE_INVERT'
>    #define RME_DIGIFACE_INVERT BIT(32)
>                                ^~~~~~~
>    include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
>    #define BIT(nr)                 (UL(1) << (nr))
>                                           ^  ~~~~
>    6 warnings generated.
> 
> 
> vim +3000 sound/usb/mixer_quirks.c
> 
>   2995	
>   2996	static int snd_rme_digiface_get_status_val(struct snd_kcontrol *kcontrol)
>   2997	{
>   2998		int err;
>   2999		u32 status[4];
>> 3000		bool invert = kcontrol->private_value & RME_DIGIFACE_INVERT;
>   3001		u8 reg = kcontrol->private_value >> 16;
>   3002		u16 mask = kcontrol->private_value & 0xffff;
>   3003		u16 val;
>   3004	
>   3005		err = snd_rme_digiface_read_status(kcontrol, status);
>   3006		if (err < 0)
>   3007			return err;
>   3008	
>   3009		switch (reg) {
>   3010		/* Status register halfwords */
>   3011		case RME_DIGIFACE_STATUS_REG0L ... RME_DIGIFACE_STATUS_REG3H:
>   3012			break;
>   3013		case RME_DIGIFACE_CTL_REG1: /* Control register 1, present in halfword 3L */
>   3014			reg = RME_DIGIFACE_STATUS_REG3L;
>   3015			break;
>   3016		case RME_DIGIFACE_CTL_REG2: /* Control register 2, present in halfword 3H */
>   3017			reg = RME_DIGIFACE_STATUS_REG3H;
>   3018			break;
>   3019		default:
>   3020			return -EINVAL;
>   3021		}
>   3022	
>   3023		if (reg & 1)
>   3024			val = status[reg >> 1] >> 16;
>   3025		else
>   3026			val = status[reg >> 1] & 0xffff;
>   3027	
>   3028		if (invert)
>   3029			val ^= mask;
>   3030	
>   3031		return field_get(mask, val);
>   3032	}
>   3033	
> 

~~ Lina


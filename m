Return-Path: <linux-kernel+bounces-258721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B5C938C21
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766A0281B85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E8116C6A4;
	Mon, 22 Jul 2024 09:33:48 +0000 (UTC)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9E716A945
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640828; cv=none; b=MlgZTmxrYgpH2/PF6xhfIYhweY7UF5QFp8ha8YhXYYfDlbC0vhpUuJXCn7gnCPJyA4OtPKiLF+yUtJfnBg5Mfei3bsrN9Qd3qcwuVppu21Tu6S5w15nKEGHQ30luz/Pazvrh0R7x0skznQZuxN3IL2KMHcmeyU1N7/z/nnacuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640828; c=relaxed/simple;
	bh=74sKzrcRLF3sE51Un0CO6Zd7Kq9R6SfffjcOrEAVLfU=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DFMVJ141ntOP3GW2HnX5rE9Y/rRDevmKXTOnQT2iev3NAmZ/nGZtFMbw2VlyBocL6lqWHCVGN9DsJPrxIPqanSQ5MksavKDpzpr80xLnO7PaAfb5UNmALaVIMhCEMD6CmKhjinfFCCQEkEz+x9oI281DS2wLzGygGd9OlCwLvTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxJMX_Hp5mmO5TAA--.45177S3;
	Mon, 22 Jul 2024 16:57:36 +0800 (CST)
Subject: Re: arch/loongarch/kernel/alternative.o: warning: objtool:
 apply_alternatives+0xa0: unreachable instruction
To: kernel test robot <lkp@intel.com>
References: <202407221208.6SSBeN9H-lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Huacai Chen <chenhuacai@kernel.org>, Jinyang He <hejinyang@loongson.cn>,
 Youling Tang <tangyouling@kylinos.cn>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a1871e00-936c-8487-a22a-efe3cc4c53a4@loongson.cn>
Date: Mon, 22 Jul 2024 16:57:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202407221208.6SSBeN9H-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8CxJMX_Hp5mmO5TAA--.45177S3
X-Coremail-Antispam: 1UD129KBjvJXoWrZr17CF1rtw1UCr4fGF4Uurg_yoW8JrW5pF
	4fXFWYvF4rXrsYga17tw1DuF1FqanxJ3W3KrykZr4UCF4qvr12krySkrW3ZF9F9wsYgry8
	Aw4xX3W3KF1jv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU0yxRDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/

On 07/22/2024 12:38 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7846b618e0a4c3e08888099d1d4512722b39ca99
> commit: cb8a2ef0848ca80d67d6d56e2df757cfdf6b3355 LoongArch: Add ORC stack unwinder support
> date:   4 months ago
> config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240722/202407221208.6SSBeN9H-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240722/202407221208.6SSBeN9H-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407221208.6SSBeN9H-lkp@intel.com/


A quick test shows that the objtool warnings are related with compiler
optimization level, it uses -Os (CONFIG_CC_OPTIMIZE_FOR_SIZE=y) rather
than the default -O2 (CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set)
in the randconfig. I will keep digging.

Thanks,
Tiezhu



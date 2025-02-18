Return-Path: <linux-kernel+bounces-518631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C363DA39233
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A31516842F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 04:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D044E1ACEDA;
	Tue, 18 Feb 2025 04:55:08 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E61ACEB5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854508; cv=none; b=PDJqrZ27gza7FnSF1TtzqDpBoyY8lxaJMfYMFA+H5GhmEZTQzY32ZadlroM6MMwHJg6qZMF4ZHdjCMZyJ/Vb+t9ZST+/yWZO6e1ZSBl7KhNNe4TdTJUlSlFJoo6NjdZA81HsMdsfyUjUqZw6Nnl8gEKVAsXT9qICVJaVhLRbu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854508; c=relaxed/simple;
	bh=8Rww1tDeYsBTVtksCnifbW9ho3ZZuv64PVKG9q+qInc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdJTAOVMrsC+jx7FwRQliqTCsUXmWkC50rlb3z3JkM5qrYjW8f7wBYCDtPXowXxL1OUm3xBeRdhuIUPodcX4tHBtgqZxxBE1LK/QxJZWy12IgLfjXnAhsxD/m3H1O2rf+Zeol1+b3NgGZzAVk5IBdcQN3o/CTyRu3VxJxi6an8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 135F544291;
	Tue, 18 Feb 2025 04:55:01 +0000 (UTC)
Message-ID: <ca8bf710-f77a-42b7-92ed-5d6ef9fe44b5@ghiti.fr>
Date: Tue, 18 Feb 2025 05:55:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mm/workingset.c:621 workingset_update_node() warn: unsigned '_x'
 is never less than zero.
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "T.J. Mercier" <tjmercier@google.com>, linux-riscv@lists.infradead.org
References: <202502160323.ZLUfooA0-lkp@intel.com>
 <20250217202127.cf92afe2c0a89d5865e1811b@linux-foundation.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250217202127.cf92afe2c0a89d5865e1811b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepkeefkeetveejgfelheefvefhvedvfefhieegiedtkefgjeetffejueekgefggfeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptddurdhorhhgpdhinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemugeifeejmegrhehfieemrgefhedtmeejvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeguieefjeemrgehfheimegrfeehtdemjedviedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemugeifeejmegrhehfieemrgefhedtmeejvdeingdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlkhhpsehinhhtvghlr
 dgtohhmpdhrtghpthhtohepshhhrghkvggvlhdrsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtohepohgvqdhksghuihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehrohhmrghnrdhguhhshhgthhhinheslhhinhhugidruggvvhdprhgtphhtthhopehtjhhmvghrtghivghrsehgohhoghhlvgdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Andrew,

On 18/02/2025 05:21, Andrew Morton wrote:
> On Sun, 16 Feb 2025 03:56:06 +0800 kernel test robot <lkp@intel.com> wrote:
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   7ff71e6d923969d933e1ba7e0db857782d36cd19
>> commit: 4715c6a753dccd15fd3a8928168f57e349205bd4 mm: cleanup WORKINGSET_NODES in workingset
>> date:   9 months ago
>> config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250216/202502160323.ZLUfooA0-lkp@intel.com/config)
>> compiler: riscv32-linux-gcc (GCC) 14.2.0
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202502160323.ZLUfooA0-lkp@intel.com/
>>
>> New smatch warnings:
>> mm/workingset.c:621 workingset_update_node() warn: unsigned '_x' is never less than zero.
>> mm/workingset.c:746 shadow_lru_isolate() warn: unsigned '_x' is never less than zero.
>>
>> Old smatch warnings:
>> include/linux/mm.h:1306 virt_to_head_page() warn: unsigned '_x' is never less than zero.
>>
>> vim +/_x +621 mm/workingset.c
>>
>>     617	
>>     618	void workingset_update_node(struct xa_node *node)
>>     619	{
>>     620		struct address_space *mapping;
>>   > 621		struct page *page = virt_to_page(node);
> We're seeing several reports like this.  It looks like the RISC-V
> virt_to_page() (actualy __pa) implementation needs some attention.


Yes, Christoph reported the same warning yesterday, we are discussing it 
since it is probably a false-positive 
https://lore.kernel.org/linux-riscv/Z7PWuSA4jtZnxp5J@rli9-mobl/T/#t.

Thanks,

Alex


>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


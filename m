Return-Path: <linux-kernel+bounces-322677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E87972C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96AA1F25061
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B401318593C;
	Tue, 10 Sep 2024 08:32:02 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8F149E00
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957122; cv=none; b=FXynggdIHRvN2Po3mtEH6LMpB8rrFqYDCjtyPdMVYM+w/2B2/IdTPOj+hAfanBDMDDrwtwJiBHp4pTpzaxsUm76aH9uqFivLtaj0lCuTID3PlMXwvI+GBgfDo37WHEkIaxlXhoxYy59BK9gqhtLeUGzH8TDik5JdZWAIqmYY/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957122; c=relaxed/simple;
	bh=0ZC1EPimLiLr7+22kVOFzwzAt7yCsqx3Rezztt0tXQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQnhdZS/7xWADmoYCOEhBXAcki2kvWv4F6ocy83QkAxOYNzcF3cG9z6hhk9k4cV8P4VJaqCGDOijMOpTzdJRFZd3GNKIQDkPdWquuCQdcVsZIwhzYbu1jMGzTGLJQaHpLqgmljz3UHl+nET4C+4NV50Ju0lCgaVK7yAEiCK/yJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X2xl203YTz9sPd;
	Tue, 10 Sep 2024 10:31:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WECQOnNEitDQ; Tue, 10 Sep 2024 10:31:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X2xl16Dtlz9rvV;
	Tue, 10 Sep 2024 10:31:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C2E588B770;
	Tue, 10 Sep 2024 10:31:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WK6MAQwnSTyr; Tue, 10 Sep 2024 10:31:57 +0200 (CEST)
Received: from [192.168.232.177] (unknown [192.168.232.177])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 574848B766;
	Tue, 10 Sep 2024 10:31:57 +0200 (CEST)
Message-ID: <125adbe2-453e-4b02-a7c5-25f655b431a7@csgroup.eu>
Date: Tue, 10 Sep 2024 10:31:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: No rule to make target 'arch/powerpc/boot/dtbImage.ps3', needed
 by 'arch/powerpc/boot/zImage'.
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>,
 Anders Roxell <anders.roxell@linaro.org>, naveen@kernel.org
References: <CA+G9fYvG3Tv-Gk6f6oSTuY4=sJWMcF5oRc9Qe1otFvetysm4zw@mail.gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <CA+G9fYvG3Tv-Gk6f6oSTuY4=sJWMcF5oRc9Qe1otFvetysm4zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/09/2024 à 21:25, Naresh Kamboju a écrit :
> The Powerpc cell_defconfig and mpc83xx_defconfig builds failed on the
> Linux next-20240909 due to following build warnings / errors with gcc-13 and
> clang-19.
> 
> First seen on next-20240909
>    Good: next-20240906
>    BAD:  next-20240909
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> build log:
> --------
> make[3]: *** No rule to make target 'arch/powerpc/boot/dtbImage.ps3',
> needed by 'arch/powerpc/boot/zImage'.
> make[3]: Target 'arch/powerpc/boot/zImage' not remade because of errors.
> 

See 
https://lore.kernel.org/linuxppc-dev/b154ab25-70f6-46cd-99db-ccfbe3e13fb7@csgroup.eu/T/#m7cc489243ce5a17af97ff8ec7cc15c663565b6fd

Christophe


> 
> Build Log links,
> --------
>   - https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fqa-reports.linaro.org%2Flkft%2Flinux-next-master%2Fbuild%2Fnext-20240909%2Ftestrun%2F25078675%2Fsuite%2Fbuild%2Ftest%2Fclang-19-cell_defconfig%2Flog&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7Cbea1fddc11ef4588817208dcd118fdb1%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638615152486474122%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=k4QsFvSrqrtJkwe5i8qvTetu941J%2FiokAMEDIy1hgO4%3D&reserved=0
> 
> Build failed comparison:
>   - https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fqa-reports.linaro.org%2Flkft%2Flinux-next-master%2Fbuild%2Fnext-20240909%2Ftestrun%2F25078675%2Fsuite%2Fbuild%2Ftest%2Fclang-19-cell_defconfig%2Fhistory%2F&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7Cbea1fddc11ef4588817208dcd118fdb1%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638615152486482765%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=hZJF6oi09QQnOcjWlPkn5YQw3L33uG5vobqZX%2FJzW%2Fc%3D&reserved=0
> 
> metadata:
> ----
>    git describe: next-20240909
>    git repo: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.com%2FLinaro%2Flkft%2Fmirrors%2Fnext%2Flinux-next&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7Cbea1fddc11ef4588817208dcd118fdb1%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638615152486487967%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=FIZK7ic0Dwbnt8zclmji5w2mTS0konX%2Bh6izCQ2QoqQ%3D&reserved=0
>    git sha: 100cc857359b5d731407d1038f7e76cd0e871d94
>    kernel config:
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fstorage.tuxsuite.com%2Fpublic%2Flinaro%2Flkft%2Fbuilds%2F2lpXzh3wwbuC6nYpMV2nPNA0IpF%2Fconfig&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7Cbea1fddc11ef4588817208dcd118fdb1%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638615152487540129%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=KPpD9d%2FM2gxLqjaVIsN26jwolSkzetd%2B0VGVMaV4Mwo%3D&reserved=0
>    build url: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fstorage.tuxsuite.com%2Fpublic%2Flinaro%2Flkft%2Fbuilds%2F2lpXzh3wwbuC6nYpMV2nPNA0IpF%2F&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7Cbea1fddc11ef4588817208dcd118fdb1%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638615152487548564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=dS0BYsDDrcnW7fF2KeUZFBvFKnMKLz36nLWt%2BmeqIIQ%3D&reserved=0
>    toolchain: gcc-13, clang-19 and clang-nightly
>    config: cell_defconfig and mpc83xx_defconfig
> 
> Steps to reproduce:
> ---------
>   - # tuxmake --runtime podman --target-arch powerpc --toolchain
> clang-19 --kconfig cell_defconfig LLVM_IAS=0
>   - # tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
> --kconfig mpc83xx_defconfig
> 
> 
> --
> Linaro LKFT
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkft.linaro.org%2F&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7Cbea1fddc11ef4588817208dcd118fdb1%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638615152487553541%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=Pzu3tW7FdI%2F7FYj%2BUSz%2FTfENPPGRZUEf%2FsXcaSpPXB8%3D&reserved=0
> 


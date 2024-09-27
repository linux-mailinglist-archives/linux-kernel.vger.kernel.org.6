Return-Path: <linux-kernel+bounces-341581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDB49881FC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD811F21F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B281BB693;
	Fri, 27 Sep 2024 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="Gs3y2F44"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3E2AD31;
	Fri, 27 Sep 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430936; cv=none; b=DWxfI+VklW10C7TG9UVHzxSKkVSVFJCAEs2PNQyRKSmb8tEP/cpp86Faea1z1Pp9SuXTaemkfKab9Gfl+nOIJLlPnEmZWenw8DLQdxDbG+76mSTEgY4YPC6V4txurVYApK7on37wBQKo/m7kRg0m3X8LTmCHCPyQ4WQqe4cWyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430936; c=relaxed/simple;
	bh=VnA47Zt1tLK42DvhfMynoQz9iS5dswX0Ju2s6tG2g3M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=i16gZEzeHR1hxr03JEJkl6Wl5bXkOEHieYBL3jNyZAl8cXyDXh+d96ld2FCEgysUbMLsu607ISJ0uhY46R1rqSO5B9JSIkp4k0UinSHT962baB6VuwloZI+o+KvOS+qtcjXkXhNvoQz67Y7CIQLtuXN5aJ7b/h8sxb1BdaK1KcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=Gs3y2F44; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 1D00E302A02;
	Fri, 27 Sep 2024 11:55:26 +0200 (CEST)
Authentication-Results: ext-mx-out013.mykolab.com (amavis);
 dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:content-type:content-type:message-id
	:references:in-reply-to:subject:subject:from:from:date:date
	:mime-version:received:received:received; s=dkim20240523; t=
	1727430923; x=1729245324; bh=tMGNwHc0WSv8ww/AbbjoPGWbFWMBTPhFAxy
	PpIwMkNU=; b=Gs3y2F44PRqWeUt15QDVS4PAZPWEIpMGmNX5q72tSGPeBjaa8pb
	GEJv+qdqm70MRr3JlZPYgwkcsms0K8dHYjeCI0IrHO7i1VTJOl+WTZrm5v5Je5i9
	0K01r3YWbu6kC91vejsWBBPh2knyW9oNRP75LiXAUbIvt+zSw7aByDC62+d+YUG6
	wtsquqH7/1odljWrlKqZiP5lcufd3jjK/bbWJptxJhmCBjIUp/IMtceEgjp3gRw/
	oseJzbEwxSyJBUZyRpVuH3wyRG1dU8dH5abV/MyDsFNpAr6zzsFhHzUrqIu1tXBI
	GmerC7Ke4iD20o90i5Tt6wyS+GkUM/6a+Tg==
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out013.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id rdsO9j1002ns; Fri, 27 Sep 2024 11:55:23 +0200 (CEST)
Received: from int-mx011.mykolab.com (unknown [10.9.13.11])
	by mx.kolabnow.com (Postfix) with ESMTPS id AF461302A00;
	Fri, 27 Sep 2024 11:55:20 +0200 (CEST)
Received: from int-subm015.mykolab.com (unknown [10.9.37.15])
	by int-mx011.mykolab.com (Postfix) with ESMTPS id 98D3C309048F;
	Fri, 27 Sep 2024 11:55:20 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Sep 2024 11:55:20 +0200
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: kernel test robot <lkp@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, oe-kbuild-all@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc:it_IT: update documents in process/
In-Reply-To: <202409250825.r3iY80XD-lkp@intel.com>
References: <20240924224635.21472-1-federico.vaga@vaga.pv.it>
 <202409250825.r3iY80XD-lkp@intel.com>
Message-ID: <d50ee871d2bdc35192be9729176759a1@vaga.pv.it>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

I'll come back with a fix for this warning.

On 2024-09-25 02:41, kernel test robot wrote:
> Hi Federico,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on lwn/docs-next]
> [also build test WARNING on next-20240924]
> [cannot apply to linus/master v6.11]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:
> https://github.com/intel-lab-lkp/linux/commits/Federico-Vaga/doc-it_IT-update-documents-in-process/20240925-064806
> base:   git://git.lwn.net/linux.git docs-next
> patch link:
> https://lore.kernel.org/r/20240924224635.21472-1-federico.vaga%40vaga.pv.it
> patch subject: [PATCH v2] doc:it_IT: update documents in process/
> reproduce:
> (https://download.01.org/0day-ci/archive/20240925/202409250825.r3iY80XD-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> https://lore.kernel.org/oe-kbuild-all/202409250825.r3iY80XD-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    Documentation/userspace-api/netlink/netlink-raw.rst:
> :doc:`tc<../../networking/netlink_spec/tc>`
>    Documentation/userspace-api/netlink/netlink-raw.rst:
> :doc:`tc<../../networking/netlink_spec/tc>`
>    Warning: Documentation/devicetree/bindings/power/wakeup-source.txt
> references a file that doesn't exist:
> Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
>    Warning:
> Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> references a file that doesn't exist:
> Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>    Warning: Documentation/hwmon/g762.rst references a file that
> doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
>>> Warning: Documentation/translations/it_IT/process/4.Coding.rst 
>>> references a file that doesn't exist: 
>>> Documentation/translations/it_IT/process/clang-format.rst
>>> Warning: Documentation/translations/it_IT/process/coding-style.rst 
>>> references a file that doesn't exist: 
>>> Documentation/translations/it_IT/process/clang-format.rst
>    Warning: Documentation/userspace-api/netlink/index.rst references a
> file that doesn't exist:
> Documentation/networking/netlink_spec/index.rst
>    Warning: Documentation/userspace-api/netlink/specs.rst references a
> file that doesn't exist:
> Documentation/networking/netlink_spec/index.rst
>    Warning: MAINTAINERS references a file that doesn't exist:
> Documentation/devicetree/bindings/reserved-memory/qcom
>    Warning: MAINTAINERS references a file that doesn't exist:
> Documentation/devicetree/bindings/display/exynos/
>    Warning: MAINTAINERS references a file that doesn't exist:
> Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt

-- 
Federico Vaga
http://www.federicovaga.it/


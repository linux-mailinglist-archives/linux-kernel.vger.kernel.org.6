Return-Path: <linux-kernel+bounces-182365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A852C8C8A64
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0591F23967
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F0913D8B6;
	Fri, 17 May 2024 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rYPq6X2N"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57512F398;
	Fri, 17 May 2024 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964957; cv=none; b=tah1HunL1Ywltktf5CLXO52dt1yeOfqRrCviTgAk+2P/2gUb/8FPjSA5qcExFR7Ndnwb2EMGTtynLVvBPPnPIvKYnX/xG5AwtIEqbvpvQgXGFzBO6i1pFbZ4TxTp/Dx/aqHR3fUQZbQVE1cBp/SKFEv85nQqoeBofX2C9ATyfGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964957; c=relaxed/simple;
	bh=oS+zk2HYc2BOzJVr2+JxzzDk4PthvgRnZztNAdo8rGM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qCW3JALVhI3TQUlphSO9UIxADVo3RtikWyFgC4kR4ccRivk3qTqY/iP/wth775xCwGNGA7aFeZhRvqTr9785GYiHhyS7VBqu/9bnIZzXce+XdQuBHUAghnd0k+11+5DEKjue40/YWSFfPmXR3uKvVnHB9GAmHF4dCPCQ8FITmlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rYPq6X2N; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715964921; x=1716569721; i=markus.elfring@web.de;
	bh=opJ3yzwn4W/yGFt1CijxFGqOb7XueZ6TGIqHxjcuutE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rYPq6X2Nm3ZNWdgRT56yWY1UNvOnzO/3D0uY+m91uIkGYi2DHkhQUvl8ScoVvN1k
	 vXX4N21+6TSnxw1Gi1j9mHQZOUj6jQrvHkp119OEhtmN9X+j6VQppa9pKgsBO0O7T
	 6nx386VFiPY0phbLlCftuhMzxaLaHvOZ8ZDMIkMp402+bVheNAq0an7bSbfDaYSnF
	 GEgvza4Hvn/DK2OL1wLC746u7Xf+sQ2PreOkmj4/R+05M6DGiPakVE24LUaQhpVsA
	 UHHodsFafoPoPebIYHCK/+1EMcS+EGj1SCVA4T2ILp90VhOrYSSt3TYorIzRBZlc6
	 NnBafwdaoS9r0A0M/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdHE-1rrZuH0mpo-00TEYo; Fri, 17
 May 2024 18:55:21 +0200
Message-ID: <81a50343-34e3-4a4d-80e9-0c674876cdb8@web.de>
Date: Fri, 17 May 2024 18:55:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <zhiguo.niu@unisoc.com>,
 linux-f2fs-devel@lists.sourceforge.net, kernel-janitors@vger.kernel.org,
 Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hao_hao.Wang@unisoc.com,
 =?UTF-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
 Zhiguo Niu <niuzhiguo84@gmail.com>
References: <1715945202-30045-1-git-send-email-zhiguo.niu@unisoc.com>
Subject: Re: [PATCH] f2fs: fix to check return value of
 f2fs_allocate_new_section
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1715945202-30045-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F5vmjCW5AwisAA6fyRSakYagc++ce9s74l6fZprZXTpp00HIYJ9
 ZPVZZxE8Ppth6r+STxzWbnVtuy86HwVhP+V9kKlQQz4xmAQM8aQQorcVkxuIh8n/ELIMVlu
 yyZQDFGQcO/ohrju1o9n4jZSwl1SaYIln0gvIvgkurlqBdH8Bw+YpWMa7y/BwyMBIuuf2gW
 mO2yhHD+4mL4lyVcU2I3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/BR6hDIGdNA=;YrAo6ZeUPbgYxIb9yjqSQRcXuE8
 EdOcrOthGfV2mqTsHCyjDj4RVAsyaAa7hKmV0BaoaScDPXMKjX5NxSPtOpRMqygwltGUBJyB0
 fNIFBslKb7KJjb6laFkDBWcouWZ5LTV0aC/EfuFYRTekkOsmPHJ9ySrEC8tFrptwrYbfd/6Hk
 6uOWHuLck0UMdI6Q6fMEdHjSJXdJEeTnMBp0kYjgKd4nndRel80+DiA3AkF/2Wy780xvItGOU
 97RHNmK+ZHAlq28v9ZI9FNsRD9NR2UBPdVQnVnqauB12KUvsGisKYHAjJl4pejTRInUM5PMyM
 QN5yWZpnb+GyiCRm9hbOv44HaEbFDLXtk64KKPCuoCke9BkpQfmNZTPKeIFsuySomBOqWmOpy
 QZNcfEUK7mokuxJzJE1EwDH0s/nAKlA8z2k9l9HnRT5h4EwntB7Cs6qQv9y4Lygbu1c7/WjZR
 Jpms47riUmEiFjRpXsGbL9ZrKWCArHbUWv3nOUGZ3q/sGygojZHWpGquF9zE6iACXf3NvFLbW
 PmvzoX7d/Q2OHWIBDMALZjL9/5ZPYX++ula/p3oCJCdwW6u4qKaimVFNKd9qS7Lj21oBpg16W
 5Wz4AwALbWiXn+isBkwWRhbXqHNJ2PMjEJudZEQc2OYd1cuCFTU8S2T+6YE9icovNBjoldu5Z
 GGgYmCtVKtZXr5K97TRSlIFb70xc6nUd7KCiPVCQmBwBwkEwig6n5EaswclRtUZyFgwW98Jvc
 de96CE88C+euWU4i2waTWpd8iwOMPV5aTJkSVGV6AO8gHxHUCpWBL7303BMd/8T/TCVSW2N3I
 60KNP29o317ojSYDcQAWRsY+G4Ob+wGZFKytB9VGvvumc=

=E2=80=A6
> missed this allocated path, fix it.

* Will another imperative wording be desirable for an improved change desc=
ription?

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D?

* How do you think about to append parentheses to the function name
  in the summary phrase?


Regards,
Markus


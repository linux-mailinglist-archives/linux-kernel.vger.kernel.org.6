Return-Path: <linux-kernel+bounces-524703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F0A3E60C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC416189F59A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B4C211A1D;
	Thu, 20 Feb 2025 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="FtU5Tkue";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="fXr1Oxe6"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F71E9B3C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084341; cv=none; b=FsVLnVGIIi6YdPHMgSAz5jvMfdY+AGY97bHsHgvzKmmEvZVcgNxI2Svmr+w5hWo1iCjDtDd4xVcW9iZEyVzFIUWLjjemvScUx2KQG3mzE1h34K1RA19sA09b9GLsCWIh6DPH/OW7akSdipOevxprzhU954DX7Gg2/l57+R2Y+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084341; c=relaxed/simple;
	bh=3tbGpWfDHGaJ9/s2PSOb4z2HOm8MEgHRnPktyxUdylQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9LM5EgYMh6c+lWAbYFo923k7GPqPl5NzoXbuctZS3vqwPXze38L3cJTcavknJyJoxsdtTXiKSgBFFQfJercEUDq3G/Aut1mpva3I5TNfJ+Hrgc2qYxRO83/xMlSeiZxC59ZxbVKZcJNgtoRX3PemGB82HT1SEGKE+/27B49OYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=FtU5Tkue; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=fXr1Oxe6; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=FntsL4GwmN3SvMUBbKd+19xK7r8pdM9oyUm5MKitCPA=;
 b=FtU5TkueYHqB3rc1TJJ1MvkxqYx8ScbI1H44X8UACOztO7RGuBLUror2690lWyeq3paKvpxdHQw/F07cxsCSUYE3OcwRJ0w0B9TVZwVISQ711AMANNpWEpAJFx55BQtmAgDJ7Ha52DAoeBV18PeWUngfghr2xrx1kMz50yHNvyFGG5ANIa7DZIK6X31hPGXntAyBlyfHQtQGSbzBt0/xYs7ypX3CiCBHCVadOhvL7YD7JxgDunJFSEt6WSdUPYIe2Coua/vzh1epzhUqAzwdeyxTwqAVCsLqhLf8v2z21Tlp2Q41G0QUQ3wOmi/EjuaFbk6p3NKpbK5fsPk9TcGQRA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D5CFC34005A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:45:36 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47206aad920so28953721cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740084335; x=1740689135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FntsL4GwmN3SvMUBbKd+19xK7r8pdM9oyUm5MKitCPA=;
        b=fXr1Oxe62nu08x2awskgd9HwG2ioYrmykVJRFPu/NkOOfjSaRV5ClxZxinW7guuhju
         g0ZLYwEEBI75R4ms5HmdT3dEaIQ8kECnltj9ixHYebKqbiPPOh+XANH1UU1Iz4AHdQFO
         9YyezYnN+fODPuHHdwoqLc1yLnrmmVKhD9nFqevyhZy28On4dhyN96lm/jwLFh6ZiN9B
         BwQmI9+IgkU2H2OnU4EOK2zzqhf0kLHfFJgmyE2833PTHW4uq/UjOXEs7nVVtVcfjmg3
         9O66Jdwbca0qS5fxiRzmaFRsOmcW4oSE7Rm5Qjyo33Mcuah8iDfhKtOA3jaxYVqg1SwV
         jorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740084335; x=1740689135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FntsL4GwmN3SvMUBbKd+19xK7r8pdM9oyUm5MKitCPA=;
        b=SvhydK7WXXimP8JHwwOIeZwIG2cYjFgva8TKlCxj4fRMUInZcAOSUG8Oomj3bY/GWE
         QFzb8srMp/gVoTcjuUmSCeFgvNDpwhOx5SLaHpA21UHpxiXif8NuCIo2WZNSH4zPE0SP
         P2/wlDGcvee8NhyTEETccNK3F1ARdF/QyXsG1kVsSHBkMFf5AySmzaf58XRiwkDDp+zz
         U7jeEEEkyQawf/Q+Xro5n9f57Z+h81IocF+48A0jUQ/aud+useBLUGY7zdwV8SICoc9t
         S0EIs5UE+UIeOtmwMluNmQYgCPSssPrZ97NPu6IcHLLREiLzaUDcKl4l4A4hH5e5gCXG
         dvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiapaHT5MTj8w0n1uZuwxxKoheVBAQeZJHfYm90Zd+ewUzA+MMNM4h+3tD5R59botp3BB2j1DqT03RpBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpELNx4jsxU7eDbUpH6l5WJ+ZqDOLxOyRZkX3mq3zgJXqEvY/d
	8pVgP5AEF5cej+x7DR7Z+NRSnQPMEWc5CoTt0vfWvk4VKplryNakX001IL2GyZguOtxoBaknmtk
	FGz+a91+nhLy4L0lGCovvpAx/ffDOvhLezAs8deFGqEJ4uKDsuRZKLjbNB4u/pvXEzXbUcHMDnr
	n0kIMLVXsDpc5Vy4Gbgw==
X-Gm-Gg: ASbGncvohtqkteiSK1qgusB1lv7y7olnzOW7MztzEcE4WzjkoE2X2TbpuAD++fuFUOk
	XR3GYVcR9juFasb8K1Tvtgu/UkTm7uEWS3q1vzxhMcChD9ZHbWixLWZe27ntZiK/mAqi6BpY8y0
	1qZyNkcPbLf3oGvD4J54gLmW4nS1rJNy905WA+EB2nNspcrkbjR9FoSfj4eYeW84QC17MAaHZ+w
	7b6A21xsQpOH+DvdOeFwZZvSx9TCgJDr0gugmdSalCzzJ8Tx9r45gPYFnuboVZm5B2182iktCkq
	dky00j0YXwBuG6N6oceiqJelG8MfWAII99J5wveloPGcfgqjKsuE71Cy4bVXcB9sD+XQ
X-Received: by 2002:ac8:5a48:0:b0:472:789:470d with SMTP id d75a77b69052e-47222944fe7mr10443891cf.36.1740084334997;
        Thu, 20 Feb 2025 12:45:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQosCl4HAObZR+gD2ypndpi1fkZxJJzZq4SMPEu28yg/MQCOKxm2JLseDQR8qw3CWe7vam+g==
X-Received: by 2002:ac8:5a48:0:b0:472:789:470d with SMTP id d75a77b69052e-47222944fe7mr10443621cf.36.1740084334496;
        Thu, 20 Feb 2025 12:45:34 -0800 (PST)
Received: from [192.168.86.34] (syn-076-037-141-128.res.spectrum.com. [76.37.141.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47207919e27sm26434451cf.4.2025.02.20.12.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:45:34 -0800 (PST)
Message-ID: <942770a1-6b62-448f-8210-cc7fee79c6ce@sladewatkins.net>
Date: Thu, 20 Feb 2025 15:45:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/569] 6.1.129-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250220104545.805660879@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20250220104545.805660879@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1740084337-IcuciEi_HadL
X-MDID-O:
 us5;ut7;1740084337;IcuciEi_HadL;<slade@sladewatkins.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-PPE-TRUSTED: V=1;DIR=OUT;



On 2/20/2025 5:57 AM, Greg Kroah-Hartman wrote:
> 
> This is the start of the stable review cycle for the 6.1.129 release.
> There are 569 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Feb 2025 10:44:04 +0000.
> Anything received after that time might be too late.
> 
Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my 
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade


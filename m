Return-Path: <linux-kernel+bounces-386177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A6F9B4013
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A421F23384
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1EC130A7D;
	Tue, 29 Oct 2024 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SO7hRXFU"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0D41863F;
	Tue, 29 Oct 2024 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167376; cv=none; b=Ej0DJ75ij3tMg1FztV3oFH3oHp/BUvix6/2hG0/TN7AB1HATlRTk6A/bYk+17MDVWIN7jmyxYJfIngZVnJbpL/1ByjH8PeTQjtf30M7pBX1c+fE/BMbDT1EmKhV0QYkd5EjNC5ndLhPI9YVYHSbGE+JQkLKDUomcMcK6d9DHO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167376; c=relaxed/simple;
	bh=H5yKHa85K/kN38MCbIEu0HaXLqb/id9+omWJt6O4sx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nMo8v4XlHlfYcRlurvjBXxZPu0QCWnVpr2MmrNOlb/T9Zn03/jTbCCqr5x0J/TFMIBR6mxTO1cx37v4alXrzlScacnzkG+kJmbVM/FODWX2BVbVShFTy+T4eOgJOdjwOfHJvHS+9dv8y4ppYaLoO+hEeiE/keoR8M6OukkmFFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SO7hRXFU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 871B0211F60A; Mon, 28 Oct 2024 19:02:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 871B0211F60A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730167374;
	bh=H5yKHa85K/kN38MCbIEu0HaXLqb/id9+omWJt6O4sx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SO7hRXFUATO4MXJ7fYXg2q7IHCONT3u5+UPbNgy6hMXd3yAvAnW6av7/lJ2qrIJ49
	 47A/7H4KmeVXRw7i3GUfBKChs/x3iOXGRJlAkhIYuyANWQEypwIbqKUKYoy9uppaf7
	 bTlNMKHFrfmqNYQ/+puBHQlFVoH+9v+oGAtPlKew=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	allen.lkml@gmail.com,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.6] 6.6.59-rc1 review
Date: Mon, 28 Oct 2024 19:02:54 -0700
Message-Id: <1730167374-10012-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
References: <20241028062306.649733554@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik


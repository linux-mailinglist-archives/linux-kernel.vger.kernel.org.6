Return-Path: <linux-kernel+bounces-375951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A229A9DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD294280FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9021E199936;
	Tue, 22 Oct 2024 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMbvQzCy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A40A19925D;
	Tue, 22 Oct 2024 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587455; cv=none; b=WLEbqo1x0t+klORmce91W6SyuzOk3d92MY6w3OTIN2V1DHQ9rrkyT2eNKEUjzjrprQc8+9TEmi2LnmB5D9XtRWqsFiBFJUzk7BzsXJBkk8XfwV6U0sMsu4MJrCak1phlC3ewjDIwcNxvoms9CqWia1kRhoNnmK/0G9rK0KTN23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587455; c=relaxed/simple;
	bh=fQeTcO+UGFsb0+eTNurOD3fC0NALBLaip39xHflP2zk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y0XV95ic0ufzGKoas+9BtRr6zLNTK9kB4lTGGD44hbG4UdMutlZ3AxoPJT87P8/BndJnJF5BwQOu/j3g2w61iG3zcv8BjS3JiCXXfLYqU2iI2BITotB4rIlBvecdBY/mOSlDaY9XBG+rGxIXe5iBXGx6ts0sDfu6udlsCw+Z10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMbvQzCy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729587454; x=1761123454;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=fQeTcO+UGFsb0+eTNurOD3fC0NALBLaip39xHflP2zk=;
  b=fMbvQzCyOTwloa7DQBEPCQbL++hjaGaJlHGYImUI7udZ5xhSgBpY9iBs
   8Eptfg/yyU1RdF2fAk5o8yJZdv9t4WnRc2hkuBmiSo2Qc+km0+zqWF98t
   wpuLvBzJWKLfq0RxQFrakFBR8d1WYEK7eM9zCs2iM9Iqbc+vwsfb/q8AV
   U8l/MvRA+bwQVLzGhSnkDSO18UG70lhaGIDsvj0hMk2M0B524pilm3zEl
   GzIs38EEl6P5l4LA/gOFJfksFBHcUfQazQ2aWG42D4CZ87MNlKR09hp70
   O0xD4oEtqsocsbMuNCOGsLOZ6TwJlK85zk12H9/VS3NpmcQ/IHMX7dmwo
   Q==;
X-CSE-ConnectionGUID: U2TUeFdvTbuNCs5IrGFg8g==
X-CSE-MsgGUID: jgOZWmZYREq25jyKI26STw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="40494383"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="40494383"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:57:34 -0700
X-CSE-ConnectionGUID: 73FiQSbrTISzq18BnGCMSA==
X-CSE-MsgGUID: Bok33XQ6QtCebRfyb2uT+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="80607341"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:57:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241021133705.2933464-1-andriy.shevchenko@linux.intel.com>
References: <20241021133705.2933464-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/5] platform/x86: intel_scu_ipc: Avoid working
 around IO and cleanups
Message-Id: <172958744735.2775.14648444054587447890.b4-ty@linux.intel.com>
Date: Tue, 22 Oct 2024 11:57:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 21 Oct 2024 16:34:28 +0300, Andy Shevchenko wrote:

> The first patch avoids using a workaround for IO (which seems unneeded).
> The rest is a batch of cleanups. Has been tested on Intel Merrifield
> (thanks, Ferry).
> 
> v3:
> - split patches 1 & 2 to two patches each (Ilpo)
> - preserve a comment for reading buffer (Ilpo)
> - inherited tags for new patches as the result is the same code wise
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/5] platform/x86: intel_scu_ipc: Unify the flow in pwr_reg_rdwr()
      commit: 6bd35252102e2b79acb54c74527c81c09f690759
[2/5] platform/x86: intel_scu_ipc: Replace workaround by 32-bit IO
      commit: 8b142950a5a718d55b09f08900306c75ceed2cf9
[3/5] platform/x86: intel_scu_ipc: Simplify code with cleanup helpers
      commit: ce44b96261a6af318a9e28a16f0d9749e89179a6
[4/5] platform/x86: intel_scu_ipc: Convert to check for errors first
      commit: acf1b04c6890aef9bb356195221e75ce3862f84e
[5/5] platform/x86: intel_scu_ipc: Save a copy of the entire struct intel_scu_ipc_data
      commit: f02fcc7c12a61cfcb65937a570915672fa33ce73

--
 i.



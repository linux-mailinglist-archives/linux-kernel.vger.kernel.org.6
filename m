Return-Path: <linux-kernel+bounces-386365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814729B4277
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF91C1C21681
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19ED201259;
	Tue, 29 Oct 2024 06:39:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E931EDDBE;
	Tue, 29 Oct 2024 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730183940; cv=none; b=dfB5xDr9JAy2yX09H52cWr30VzNsIlEDmNPzmwwCDqZXGuJFdxFUPA15XZImsXMtRLzTCsnnGm/NGecSzaUNkfEx9kS8QkRjQVnhllzdqcaDmvxQw+Gw/bB1BZCMDdVx+1nrGuXcy0B8dMNsJQUWxHTzTMy6s/V+6EF59OEAzMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730183940; c=relaxed/simple;
	bh=sbjKxLW00HZa0GSPXLH4Etw/ylII4RoFOXY6+21NAyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NUNrysZxAmL4SdwQBJtoWLh2Z52/eA/JZWMvFtUJl5dRhrrWFVuh82LwcqGj4zRAuOm4C3fGSk9itpCXo4/jV+uYiTJLhX+eG+wz79wBqQeXjMc5b78F59cq2h4kjhomUWyjigRfb9xxdeZDt8gKGaVANZful5bCbc0qnVuXQt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F71713D5;
	Mon, 28 Oct 2024 23:39:26 -0700 (PDT)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.67.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F4153F528;
	Mon, 28 Oct 2024 23:38:49 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: dev.jain@arm.com
Cc: Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com,
	aneesh.kumar@kernel.org,
	bp@alien8.de,
	broonie@kernel.org,
	dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@kernel.org,
	oleg@redhat.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	sj@kernel.org,
	skhan@linuxfoundation.org,
	suzuki.poulose@arm.com,
	tglx@linutronix.de
Subject: [RESEND] [PATCH v6 0/2] Add test to distinguish between thread's signal mask and ucontext_t
Date: Tue, 29 Oct 2024 12:08:32 +0530
Message-Id: <20241029063832.89364-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241009051424.333380-1-dev.jain@arm.com>
References: <20241009051424.333380-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ping....please pull this....



Return-Path: <linux-kernel+bounces-400743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64B9C11AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1491AB211AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25116218D74;
	Thu,  7 Nov 2024 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pissmail.com header.i=@pissmail.com header.b="PsPpROzq"
Received: from mail.pissmail.com (mail.pissmail.com [173.249.47.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6254218306
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.47.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018545; cv=none; b=uuEVcd1wbkwnyrvrupXwkQ2my+3WW5uEpvEbj6CPTh7m+3IcTcoAuyWyLEMG17SE20GmxbyxlINomOVG8IZsAYI4n19S1pEf82TYB3naeURO857WZ67+LYvK+3Dz/kUtWcFxrjQVlBhLMDzuLEp2m+S/dEFpgL+NssEtUdkT6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018545; c=relaxed/simple;
	bh=+CD+TPpXt3lU4nxoxW3tMNT0OEn53ASawI0ed/NJeuo=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=bO2utDIqVyZKqdQyOmyu/dJUUT50K4FZwFaM/ua1g03heJ8pfGynctcv8UJ5gr8xwd/C2Bkpej60shFRculkS/IeqP9c4AwbP+4XSoQn+V1N9w3jUPofuTKm5wcF/Evto8BqFjQ5B+O6qtPTz9pa5NsN6w34lD/bFaVuc0vO/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pissmail.com; spf=pass smtp.mailfrom=pissmail.com; dkim=pass (2048-bit key) header.d=pissmail.com header.i=@pissmail.com header.b=PsPpROzq; arc=none smtp.client-ip=173.249.47.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pissmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pissmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pissmail.com;
	s=dkim; t=1731018541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wbAgVkV20NZc2t1V+rliA3gwoLS+YbYAyFl1eZkVZgM=;
	b=PsPpROzqcHPpMhCVBXTSyTxZvzjDe2MWaiSqMcuLbisHlPfG+iRI2XQqi97J2f5Er+JEFb
	r+D+k6ag0o88P6oUAPGG7aucS3hv9UAj9d1lyeBz3NH5HUHm13XJo1HiDQWQZkL7zzE7Vf
	MAahLDVtNDuX2t/M/tSJ4Tizp9NxO1rIs/3BDcXJGjxcfEdm60Fibx19DKbizftbTVdSzW
	30CxOusyTdrDKI2HPIXUbW5d78fclrxl0n9Rkna1pyX+9rL1E2ofHfeMms9Qbvfh9MhTp/
	w92xV+r/o24iij4NlLB/cD3QOWoe+mRSoevgjnKuAEhLN0AnaKIBYbH+ddB5yA==
Date: Thu, 07 Nov 2024 22:29:00 +0000
From: mortodenoite@pissmail.com
To: linux-kernel@vger.kernel.org
Subject: Richard Stallman on the removal of Russian Linux maintainers
Message-ID: <04341f4cf2dc9efedda3a261246582c8@pissmail.com>
X-Sender: mortodenoite@pissmail.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /
Authentication-Results: mail.pissmail.com;
	auth=pass smtp.mailfrom=mortodenoite@pissmail.com

[[[ To any NSA and FBI agents reading my email: please consider    ]]]
[[[ whether defending the US Constitution against all enemies,     ]]]
[[[ foreign or domestic, requires you to follow Snowden's example. ]]]

Free software calls for giving people the freedom to cooperate.
That means a group of people are free to cooperate when they all
want to cooperate.

But that is not the precise requirement.  That is a consequence of the
requirements.  The precise requirement is that users be free to make
and distribute copies of their modified versions as free software.

Those Russian have a moral right to distribute copies of their
modified versions of Linux.  But they have no moral right to demand
that the Linux developers _use_ those changes.  Whether you use
someone else's changes should be up to you.

-- 
Dr Richard Stallman (https://stallman.org)
Chief GNUisance of the GNU Project (https://gnu.org)
Founder, Free Software Foundation (https://fsf.org)
Internet Hall-of-Famer (https://internethalloffame.org)


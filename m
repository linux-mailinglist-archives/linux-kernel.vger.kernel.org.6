Return-Path: <linux-kernel+bounces-539752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1554A4A822
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217CC1895AA1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAF242048;
	Sat,  1 Mar 2025 02:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAmTjYJH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFBB23C9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740796530; cv=none; b=VHx0t+AIY0PLGBQSyA6H26wEc29pclO3CLhL7+8WFxwVTpmlTWfuUGHi+4drjjJpF3utBX0Rr1PY2RhfG1JC3vhBMJQgcJwnU00kQmGixl8wzXDCwK7HWSPzK908Ja1r/m7E3KeqeXyYwCfLwKPo97XCt62E9FmoJ88z7v44awA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740796530; c=relaxed/simple;
	bh=CvQYTjTtycrxCXSNR+RNVfux39IKVrhBj+kf3QzeZr0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KqVb1Tw52g7kmEy93X620zqJKVkI0T4QIrti4RcOhFsv/q4ze86+Q9K2r7xkl1HwrxcSgZ/Dqm1WpYkSPad2ApAkQp4D70t8I/ZrgigKBx/NX/cNiyKGjteU+IfzpAIFuzLH4GWzo8pE0FC6kJiU0Cv3fBPVzwM04bvY0WjyWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAmTjYJH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740796529; x=1772332529;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CvQYTjTtycrxCXSNR+RNVfux39IKVrhBj+kf3QzeZr0=;
  b=BAmTjYJH2zSFh+m7sLF41G6YXMRKRdYVAHarTes6QEqAFzvronD6FjwM
   dpxbFo0QyA0y6SDdd/BM8UUc2qNoLVpnpYN82fSITp2CHBYaq0rjwHQ1o
   JYqoDXze9kK1DOIlsVKDwlz/5sfgHF5+W8/Kod25/kf+uBubTsADs/tk2
   YATkOYQQU6qlJAOf2204826fzDHMa+kIRLl9C7ExNGlDb+P3MHZzPrhsr
   5zUpX4HRNySo3fvFBTdgygHKFlfEpVVTcR/rsU2iO5jgiOqtVeWmBk4un
   GUYQgygX6e9g1MW29+S1VE5ox6gSW4FM/n5j9K1/y9OM1OMEqx4zaeumt
   Q==;
X-CSE-ConnectionGUID: 6HOEOgUMQlq4H9TVcaM46Q==
X-CSE-MsgGUID: uy83lS1QRnaPgXENdoi9cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="44553294"
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="44553294"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 18:35:28 -0800
X-CSE-ConnectionGUID: g21z6MXwTuKTDJjJVWhWRA==
X-CSE-MsgGUID: IZRkXBnwRDiBIWkmF7StDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118011792"
Received: from mderakhs-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.171])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 18:35:28 -0800
Date: Fri, 28 Feb 2025 18:35:27 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] CALL_NOSPEC fixes
Message-ID: <20250228-call-nospec-v3-0-96599fed0f33@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAP/2wWcC/23O0Q6CIBTG8VdxXIdDlNCueo/WBcExz0bgwJjN+
 e6hV7W6/H/b+e0sJEJAiORULCRAwoje5agPBdGDcnegaHITzrhgnB+pVtZS5+MImt66pmVtz4y
 WguSLMUCP865drrkHjJMPrx1P1bb+d1JFK9oYA6xRQkslzxbdcy7RTWBL7R9k0xL/FOS3wLPQd
 kLV+RlQSv8K67q+AQi1TQruAAAA
X-Mailer: b4 0.14.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v3:
- Split the CS prefix change into a separate patch. (Ingo)

v2: https://lore.kernel.org/r/20250227-call-nospec-v2-1-895a30dceaac@linux.intel.com
- Fixed the inconsistency in the use of "\" in __CS_PREFIX. (Andrew)
- Fixed the comment to reflect that __CS_PREFIX only emits the prefix and
  not the JMP/CALL. (Andrew)

v1: https://lore.kernel.org/r/20250226-call-nospec-v1-1-4dde04a5c7a7@linux.intel.com

Patch 1 simplifies CALL_NOSPEC and mimics the behavior of compiler induced
thunks.

Patch 2	adds a missing CS prefix in CALL_NOSPEC for inline asm.

---
Pawan Gupta (2):
      x86/speculation: Simplify and make CALL_NOSPEC consistent
      x86/speculation: Add a conditional CS prefix to CALL_NOSPEC

 arch/x86/include/asm/nospec-branch.h | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)
---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250226-call-nospec-b94808f0dc75

Best regards,
-- 
Pawan



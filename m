Return-Path: <linux-kernel+bounces-352825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F5A9924DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383121F22D68
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427F942077;
	Mon,  7 Oct 2024 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="PsbRT1to"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A441C7F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728282693; cv=none; b=nwwFmOPwXwqd6oSJPMovoUrkLqatqpxgw21noqFyzcRxBzl64jdHGXZqKhb40GUS/JQeoCKP6l5DYFmAOojP0uv/jb/9cv7pBjX+bpEDEvbehEpidwNVBU8Hxq9yWksW7ouQMR4IA2j6CETdjUNQ8e6ZWszhnxZLOWQmk73MNBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728282693; c=relaxed/simple;
	bh=o3vDCsP5GTwllxfF7uoUZMTT2E04ueCf11adhgtOE8o=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=CmgGqyeaH2cHhUc8FkCU67AXXgF87oDSw3gyZ4EKyHMgsZ9BxcHRF35acUcyEAlxAZF962tCj/taRfupza/v8NsYhPBWM4F7Byi7L9Le3/Wet3a/CZwwGUgeMo+yQTxw5mIKSj3xrVB5Xdrzxiedb5N+MogHiW+awdm12/QwsII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=PsbRT1to; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o1w9dzkXI1woc/KiZ8uujZ+EAmcWvoNPxV+mGLX369c=;
  b=PsbRT1tokJTB4vDh8NDT9caNOjVyQXidoCQ1jd4r/COPA0k9vmJXaPH7
   0jOQzPLjxwb/Jcr+HK7X5SjxGVOwzbEavjNcVQWxhQDCuGtMuLGOfpn5m
   Mh+li6Om+f0CaqCZEExa1bt6UxrYhya89K4KZiYU1HeuWOxAgX3eazLAF
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,183,1725314400"; 
   d="scan'208";a="187300517"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 08:31:21 +0200
Date: Mon, 7 Oct 2024 08:31:21 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Imre Deak <imre.deak@intel.com>, 
    =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/gpu/drm/i915/display/intel_dp.c:2243:6-9: opportunity for
 str_on_off(dsc) (fwd)
Message-ID: <a129cc7e-d977-d468-ce79-cfa83c438da7@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1177081226-1728282681=:3365"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1177081226-1728282681=:3365
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



---------- Forwarded message ----------
Date: Mon, 7 Oct 2024 12:54:21 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/gpu/drm/i915/display/intel_dp.c:2243:6-9: opportunity for
    str_on_off(dsc)

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Imre Deak <imre.deak@intel.com>
CC: "Ville Syrjälä" <ville.syrjala@linux.intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
commit: 78015e27b7d75ec497a9b5f14a7dc0ee9288d560 drm/i915/dp: Update the link bpp limits for DSC mode
date:   1 year ago
:::::: branch date: 6 hours ago
:::::: commit date: 1 year ago
config: x86_64-randconfig-102-20241007 (https://download.01.org/0day-ci/archive/20241007/202410071252.cWILJzrH-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202410071252.cWILJzrH-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/i915/display/intel_dp.c:2243:6-9: opportunity for str_on_off(dsc)

vim +2243 drivers/gpu/drm/i915/display/intel_dp.c

a4a157777c807d drivers/gpu/drm/i915/intel_dp.c         Manasi Navare 2018-11-28  2192
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2193  /**
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2194   * intel_dp_compute_config_link_bpp_limits - compute output link bpp limits
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2195   * @intel_dp: intel DP
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2196   * @crtc_state: crtc state
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2197   * @dsc: DSC compression mode
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2198   * @limits: link configuration limits
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2199   *
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2200   * Calculates the output link min, max bpp values in @limits based on the
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2201   * pipe bpp range, @crtc_state and @dsc mode.
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2202   *
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2203   * Returns %true in case of success.
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2204   */
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2205  bool
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2206  intel_dp_compute_config_link_bpp_limits(struct intel_dp *intel_dp,
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2207  					const struct intel_crtc_state *crtc_state,
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2208  					bool dsc,
72b2d2a6f178b9 drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2209  					struct link_config_limits *limits)
a4fc5ed69817c7 drivers/gpu/drm/i915/intel_dp.c         Keith Packard 2009-04-07  2210  {
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2211  	struct drm_i915_private *i915 = to_i915(crtc_state->uapi.crtc->dev);
0c1abaa7fbfb99 drivers/gpu/drm/i915/display/intel_dp.c Ville Syrjälä 2020-03-19  2212  	const struct drm_display_mode *adjusted_mode =
72b2d2a6f178b9 drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2213  		&crtc_state->hw.adjusted_mode;
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2214  	const struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2215  	const struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2216  	int max_link_bpp_x16;
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2217
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2218  	max_link_bpp_x16 = to_bpp_x16(limits->pipe.max_bpp);
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2219
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2220  	if (!dsc) {
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2221  		max_link_bpp_x16 = rounddown(max_link_bpp_x16, to_bpp_x16(2 * 3));
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2222
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2223  		if (max_link_bpp_x16 < to_bpp_x16(limits->pipe.min_bpp))
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2224  			return false;
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2225
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2226  		limits->link.min_bpp_x16 = to_bpp_x16(limits->pipe.min_bpp);
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2227  	} else {
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2228  		/*
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2229  		 * TODO: set the DSC link limits already here, atm these are
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2230  		 * initialized only later in intel_edp_dsc_compute_pipe_bpp() /
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2231  		 * intel_dp_dsc_compute_pipe_bpp()
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2232  		 */
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2233  		limits->link.min_bpp_x16 = 0;
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2234  	}
7c2781e41ec889 drivers/gpu/drm/i915/intel_dp.c         Jani Nikula   2018-04-26  2235
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2236  	limits->link.max_bpp_x16 = max_link_bpp_x16;
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2237
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2238  	drm_dbg_kms(&i915->drm,
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2239  		    "[ENCODER:%d:%s][CRTC:%d:%s] DP link limits: pixel clock %d kHz DSC %s max lanes %d max rate %d max pipe_bpp %d max link_bpp " BPP_X16_FMT "\n",
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2240  		    encoder->base.base.id, encoder->base.name,
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2241  		    crtc->base.base.id, crtc->base.name,
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2242  		    adjusted_mode->crtc_clock,
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21 @2243  		    dsc ? "on" : "off",
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2244  		    limits->max_lane_count,
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2245  		    limits->max_rate,
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2246  		    limits->pipe.max_bpp,
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2247  		    BPP_X16_ARGS(limits->link.max_bpp_x16));
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2248
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2249  	return true;
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2250  }
78015e27b7d75e drivers/gpu/drm/i915/display/intel_dp.c Imre Deak     2023-09-21  2251

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
--8323329-1177081226-1728282681=:3365--


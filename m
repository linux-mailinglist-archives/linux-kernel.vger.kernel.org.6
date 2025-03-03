Return-Path: <linux-kernel+bounces-542577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFDCA4CB42
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C05616C636
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E495522DFAF;
	Mon,  3 Mar 2025 18:51:04 +0000 (UTC)
Received: from smtpcafe4.ibsystems.com (smtpcafe4.ibsystems.com [66.220.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8722D4C8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027862; cv=none; b=ZitjLUhNilJpeJcVgbWIMAsRky1506dxzAHFhYGxnGp+IoflaBhVi8SL4Cg5q+gsDT25Fuau8TVunEFCB5SYs2pidhDVxWP8HbDW/vkmlTInQiAYrCM/1KhwSHtQF6LI368Jzdfvn+RYWgpwj1DIcc22dUUp5pEu8YqW8sZul1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027862; c=relaxed/simple;
	bh=abm11P8vUDOE+Z0/EOQnDs5yivh3v5U5MSMaHo4ZYKM=;
	h=Date:To:Subject:From:Message-ID:MIME-Version:Content-Type; b=ay3U44zBu/C11ZVMv6ML00fSGFt2M1A12O3Bblvs8Y/uvEsMe4UxjaeFFk0vPNhPRaoRW461n6XZLYCpxJSHAV4INGkJLWhl0uYz6gaTLDnJr6bVLBS2ojpolusHonHFlkSSmAsygriWqdVpFw10jTKGKplsin6YNkYoZ/YKRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=EDACafe.com; spf=pass smtp.mailfrom=smtpcafe4.ibsystems.com; arc=none smtp.client-ip=66.220.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=EDACafe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smtpcafe4.ibsystems.com
Received: from smtpcafe4.ibsystems.com (localhost [127.0.0.1])
	by smtpcafe4.ibsystems.com (8.15.2/8.15.2) with ESMTP id 523Ioxn52230153
	for <linux-kernel@vger.kernel.org>; Mon, 3 Mar 2025 10:50:59 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 smtpcafe4.ibsystems.com 523Ioxn52230153
Received: (from nl@localhost)
	by smtpcafe4.ibsystems.com (8.15.2/8.14.7/Submit) id 523IowoX2230152;
	Mon, 3 Mar 2025 10:50:59 -0800
Date: Mon, 3 Mar 2025 10:50:59 -0800
To: linux-kernel@vger.kernel.org
Subject: EDACafe Weekly Review : February 28, 2025
From: EDACafe Newsletter<eda_news_letter@EDACafe.com>
Reply-To: EDACafe Newsletter<eda_news_letter@EDACafe.com>
Sender: EDACafe Newsletter<eda_news_letter@EDACafe.com>
Message-ID: <1741027858.975-49938-eda_news_letter@EDACafe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4d44677d2aa5b6b3ce62181b043179ed"

--4d44677d2aa5b6b3ce62181b043179ed
Content-Type: multipart/alternative; boundary="4d44677d2aa5b6b3ce62181b043179ed_htmlalt"

--4d44677d2aa5b6b3ce62181b043179ed_htmlalt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

 

 View in your browser
[https://www10.EDACafe.com/blogs/weekly/?ee=bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D&sk=6fbe2f&run_date=28-Feb-2025]

 		
[https://www10.EDACafe.com/common/images/11/11429/1740995992/bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D/at.html]

 		 FEBRUARY 28TH, 2025 

 		 [techjobscafe EDA Jobs]
[https://EDACafe.com/common/images/10/30801/0303020010/bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D/at.html]

 Silicon Reimagined: The Next Era of AI Computing
[https://www10.edacafe.com/blogs/grahambell/2025/02/28/silicon-reimagined-the-next-era-of-ai-computing/]
 February 28, 2025  by Sanjay Gangal 

THE DAWN OF A NEW COMPUTING PARADIGM
For decades, the semiconductor industry has been defined by the
predictable cadence of Moore’s Law, which steadily improved chip
performance and efficiency. But as artificial intelligence (AI)
reaches an inflection point—evolving from experimental curiosity to
business-critical infrastructure—the industry is being forced to
reimagine silicon from the ground up.

A new report from Arm, _Silicon Reimagined: New Foundations for the
Age of AI_ [https://www.arm.com/resources/report/silicon-reimagined],
details this profound transformation. It explores how chip designers
and technology leaders are responding to AI’s unprecedented
computational demands while addressing critical challenges in power
efficiency, security, and reliability.

BREAKING FREE FROM MOORE’S LAW

For years, the industry relied on the assumption that transistor
density could continue to double every two years. That era is over. As
traditional scaling approaches reach their physical and economic
limits, chipmakers are embracing new architectures such as chiplets
and compute subsystems (CSS) to keep pace with AI’s relentless need
for power.

At the heart of this shift is an industry-wide move toward specialized
silicon. The biggest cloud providers—including Amazon, Microsoft,
and Google—are developing custom AI processors, optimized for
handling massive AI models with greater efficiency than
general-purpose chips. Meanwhile, companies like Arm are advancing
heterogeneous computing architectures, balancing efficiency and
performance with domain-specific accelerators.

THE NEW POWER PLAY: EFFICIENCY AT SCALE

AI is an energy-hungry technology. Training a single AI model can
consume as much power as hundreds of homes over its lifecycle. To
mitigate this, silicon designers are prioritizing power efficiency
through innovative memory hierarchies, advanced packaging, and dynamic
power management techniques.

Memory hierarchies are playing an increasingly critical role, with
high-bandwidth memory (HBM) and near-memory computing architectures
helping to reduce latency and power consumption. Chip stacking, using
2.5D and 3D integration, allows for more efficient data movement,
addressing a major bottleneck in AI computations.

At the same time, AI itself is being deployed to optimize power
consumption at every level—from improving datacenter energy
allocation to reducing redundancy in AI training models. The era of
brute-force computation is giving way to intelligent, energy-aware AI
systems that dynamically allocate resources based on workload demands.

THE RISING THREAT OF AI-POWERED CYBERATTACKS

AI is not only revolutionizing industries—it is also transforming
the cybersecurity landscape. Emerging AI-driven cyber threats,
including autonomous malware and AI-assisted phishing campaigns, are
forcing chipmakers to rethink security at a fundamental level.

In response, semiconductor companies are embedding robust security
features directly into hardware, including cryptographic safeguards,
secure boot processes, and AI-enhanced threat detection. Confidential
computing architectures, which isolate sensitive AI workloads from
potential attackers, are becoming standard features in next-generation
chips. Technologies such as memory tagging extensions (MTE) and secure
enclaves ensure that AI models remain protected against exploitation.

REDEFINING CHIP DESIGN IN THE AI ERA

The shift from monolithic chip design to modular, chiplet-based
architectures marks one of the most significant transformations in
semiconductor history. By allowing different components to be
manufactured separately and then integrated, chiplets enable greater
scalability, reduce costs, and open the door for more customized AI
silicon.

However, this approach introduces new engineering challenges. Power
delivery, thermal management, and data transfer efficiency between
chiplets all require novel solutions. Standardization efforts are
underway to ensure interoperability, with industry leaders working to
develop universal chiplet interface protocols that facilitate seamless
integration.

Arm’s role in this transformation is particularly notable. With a
35-year heritage in power-efficient chip designs, the company is
leading the push toward more modular, scalable solutions that can
accommodate the growing complexity of AI workloads.

SOFTWARE’S EXPANDING ROLE IN SILICON INNOVATION

AI silicon is only as effective as the software that runs on it. As
custom silicon becomes more prevalent, software ecosystems must adapt
to support new processor architectures without sacrificing
compatibility and developer productivity.

The adoption of open AI frameworks, such as TensorFlow and PyTorch,
has made it easier for developers to leverage specialized hardware
without extensive code rewrites. Meanwhile, software-defined
hardware—where AI models dynamically configure chip
behavior—represents an exciting frontier in AI computing.

Interoperability across AI frameworks is a critical concern for
developers. Embedded and IoT devices, particularly those designed for
edge AI inference, often need to function across multiple hardware
platforms. This is why developers frequently default to CPU back-ends,
as their ubiquity helps ensure broader compatibility.

Cloud-based development environments are also transforming the
landscape, offering access to extensive computing resources necessary
for training large-scale models. While AI inference often happens at
the edge, cloud-based training has become indispensable for managing
the computational demands of modern AI workloads.

A COLLABORATIVE FUTURE FOR AI SILICON

The success of AI-era silicon will increasingly depend on
cross-industry collaboration. IP providers, foundries, and system
integrators must work together to optimize compute, memory, and power
delivery at a system level.

As AI adoption accelerates, the semiconductor industry must evolve in
lockstep. This means moving beyond the constraints of Moore’s Law,
embracing custom silicon, and developing power-efficient, secure, and
scalable computing architectures.

Looking ahead, the integration of AI into chip design is poised to
redefine what’s possible in computing. Machine learning (ML)
techniques are already being used to optimize power efficiency,
improve performance, and automate aspects of chip layout and
verification. The interplay between AI and silicon will only deepen,
creating a feedback loop where AI helps design the very chips that
power AI applications.

The AI revolution is here, and the future of computing depends on our
ability to reimagine silicon for this new age. With breakthroughs in
chiplet technology, energy efficiency, security, and software
compatibility, the industry is well-positioned to drive the next wave
of AI innovation. The companies that successfully navigate this
transformation will not only shape the future of AI but redefine the
very fabric of computing itself.

 AI Factories Are Reshaping the Future of Chip Design, Verification,
and Optimization
[https://www10.edacafe.com/blogs/guest/2025/02/26/ai-factories-are-reshaping-the-future-of-chip-design-verification-and-optimization/]
 February 26, 2025  by Sanjay Gangal 

The world is at the dawn of a new industrial revolution, one powered
by artificial intelligence factories that are fundamentally changing
how chips are designed, verified, and optimized. At the Design and
Verification Conference (DVCon) 2025 in San Jose, industry leaders
from Synopsys and Microsoft outlined how AI is driving an era of rapid
transformation, forcing semiconductor companies to rethink every
aspect of chip development.

 [https://www10.edacafe.com/blogs/guest/files/2025/02/1.jpg]

Speaking at the keynote session, Ravi Subramanian, Chief Product
Management Officer, Systems Design Group at Synopsys, and Artour
Levin, Vice President of AI Silicon Engineering at Microsoft,
described how AI’s pervasive intelligence is now a primary driver of
economic growth, touching industries from automotive and robotics to
data centers and high-performance computing.

With chip complexity skyrocketing and workloads becoming increasingly
software-defined, the speakers emphasized that new AI-assisted
methodologies are essential to meet power, performance, and
time-to-market demands in the semiconductor industry.

 [https://www10.edacafe.com/blogs/guest/2025/02/26/ai-factories-are-reshaping-the-future-of-chip-design-verification-and-optimization/#more-5442]

 [https://www10.edacafe.com/blogs/guest/2025/02/26/ai-factories-are-reshaping-the-future-of-chip-design-verification-and-optimization/]


 A shift-left strategy to tackle the complexities of power domain
leakage in IC design
[https://www10.edacafe.com/blogs/siemens/2025/02/24/a-shift-left-strategy-to-tackle-the-complexities-of-power-domain-leakage-in-ic-design/]
 February 24, 2025  by Sanjay Gangal 

_Author: Matthew Hogan_

A SHIFT-LEFT STRATEGY TO TACKLE THE COMPLEXITIES OF POWER DOMAIN
LEAKAGE IN IC DESIGN 

Managing leakage power is a critical challenge for IC designers, as it
can profoundly impact a device’s power, performance, area (PPA) and
overall reliability. Leakage can manifest in various ways, from analog
gate leakage causing high current drain to digital gate leakage
leading to power management and reliability issues. Even subtle
circuit changes can introduce leakage problems that compromise the
final product. Traditionally, designers have left verification of
these leakage issues until later design stages, resulting in costly
rework. However, a shift-left approach that integrates leakage and
reliability analysis into the pre-layout phase can help identify and
address potential problems early on. By leveraging advanced EDA tools
that take a holistic view of the circuit, designers can get ahead of
leakage challenges and ensure their ICs meet the highest standards of
quality and reliability.

 [https://www10.edacafe.com/blogs/siemens/2025/02/24/a-shift-left-strategy-to-tackle-the-complexities-of-power-domain-leakage-in-ic-design/#more-267]

SHARE THIS:

	* Facebook
[https://www10.edacafe.com/blogs/siemens/2025/02/24/a-shift-left-strategy-to-tackle-the-complexities-of-power-domain-leakage-in-ic-design/?share=facebook]
	* X
[https://www10.edacafe.com/blogs/siemens/2025/02/24/a-shift-left-strategy-to-tackle-the-complexities-of-power-domain-leakage-in-ic-design/?share=x]
	* 

 [https://www10.edacafe.com/blogs/siemens/2025/02/24/a-shift-left-strategy-to-tackle-the-complexities-of-power-domain-leakage-in-ic-design/]


 		 [Verific: SystemVerilog & VHDL Parsers]
[https://EDACafe.com/common/images/10/40095/0303020010/bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D/at.html]

 		 [Post your job postings here!]
[https://EDACafe.com/common/images/10/38353/0303020010/bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D/at.html]

 		 You are registered as: [linux-kernel@vger.kernel.org].

CafeNews is a service for EDA professionals. EDACafe.com respects your
online time and Internet privacy. Edit or Change
[https://EDACafe.com/nl/newsletter_subscribe.php?action=Edit&ee=bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D&sk=6fbe2f]
my newsletter's profile details. Unsubscribe
[https://EDACafe.com/nl/unsubscribe.php?ee=bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D&sk=6fbe2f]
me from this newsletter. 

Copyright © 2025, Internet Business Systems, Inc. — 670 Aberdeen
Way Milpitas, CA 95035 — +1 (408) 882-6554 — All rights reserved. 

 

--4d44677d2aa5b6b3ce62181b043179ed_htmlalt
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "https://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<TITLE>Welcome to EDACafe.com Weekly Review - February 28, 2025</TITLE>
	<link rel="SHORTCUT ICON" HREF="https://www10.EDACafe.com/common/EDA/images/favicon.ico">
	<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style  type='text/css' >
body {font-family:Verdana, Arial, serif; font-size: 13px; margin: 0;}
.BodyStyle {background-color:white; margin-top:2px;}
font {font-size: 12px;}
a, a:visited {color:#005689; text-decoration:none;}
a:hover {text-decoration:underline;}
a:active {color:white; background-color:#005689; text-decoration:none;}
img {border:0;}
h1, h2, h3, h4 {margin-top:0; padding:0;}
h1 {font-weight:normal; margin-bottom:10px; font-size:28px;}
h2 {font-size:17px; margin-bottom:3px;}
h3 {font-size:14px; margin-bottom: 3px;}
h4 {font-size:12px; margin-bottom: 3px;}
pre {white-space:-moz-pre-wrap !important; white-space:pre-wrap; white-space:-pre-wrap; white-space:-o-pre-wrap; white-space:-hp-pre-wrap; white-space:pre-line; word-wrap:break-word; _white-space:pre; overflow:hidden;width:528px;}
.TopHeader {margin-top:5px; margin-bottom:8px; text-align: left;}
.SiteLogo {width: 240px;margin-left: 0px;margin-top: 0px;padding-left: 5px;float:left;}
.SearchHeader {width:236px;}
#MainSearchText {width:160px; float:left; margin-right:3px;}
#MainSearchBtn {float:right;}
.ColumnWide {width:310px; float:left;}
.ColumnNarrow {width:160px; float:left;}
.ColumnNarrowPlus {width:210px;	float:left;}
.ColumnHalfContent {float:left; width:260px;}
.ColumnBorder1 {padding-right: 3px; margin-right: 0px; border-right: 1px solid #bebebe;}
.ColumnBorder{padding-left:3px; padding-right:3px; margin-right:0px; border-right:1px solid #bebebe;}
.viewArticleTitle{font-family: Lucida Grande,Lucida Sans Unicode,Arial,verdana,helvetica,sans-serif;}
.viewArticle_box {float: left; padding: 2px; margin-top: 3px; margin-bottom: 5px; margin-left: 0px; margin-right: 0px; background-color: #dddddd; border-bottom: 1px solid #444444; border-top: 1px solid #444444;}
p#PURL, #mmgallerylink-phrase, #mmgallerylink-link {display:none;}
.SetCursorPointer { cursor: pointer;}
.left {text-align:left;}
.center {text-align: center;}
.right {text-align:right;}
.top {vertical-align:top;}
.middle {vertical-align:middle;}
.bottom {vertical-align:bottom;}
.fontBold{font-weight:bold;}
.fontNormal{font-weight:Normal;}
.floatRight {float:right;}
.floatLeft {float:left;}
.hide{display:none;}
.underline {text-decoration: underline;}
.nowrap {white-space:nowrap;}
.cursorHelp {cursor:help;}
.cursorPointer {cursor:pointer;}
.standardLink a {color: #4273d9; text-decoration: underline;}
.standardLink a:visited { color: #8155c8; text-decoration: underline;}
.standardLink a:hover { color: #005689; text-decoration: underline;}
.BoxItemForumLink {text-decoration:none;}

.HeaderNav
{
	background-color: white;
	font-size: 14px;
	font-family: Georgia, sans-serif;
	padding-bottom: 3px;
	margin-left:0px;
	border-bottom: 1px solid #ccc;
	/* width: 100%; */
	/*float: center; */
	text-align: center;
	margin-top: 0;
	left: 0;
	right: 0;
	top: 0;
	text-align: left;
}

.HeaderNav a, .HeaderNav a:visited, .HeaderNavMore a, .HeaderNavMore a:visited
{
	margin-right: 6px;
	padding: 2px;
	color: #005689;
	text-decoration: underline;
}

.HeaderNavLastLink
{
	margin-right: 0px;
	font-size: 14px;
}

.HeaderNav a:hover
{
	text-decoration: underline;
}

.HeaderNav a:active, .HeaderNavMore a:active
{
	color: white;
	background-color: #005689;
	text-decoration: underline;	
}

.HeaderNavMore a
{
	font-size: 14px;
	font-family: Georgia, sans-serif;
	text-decoration: underline;	
}

.SearchHeader, .SearchHeader input
{
	font-family: Verdana, Arial, serif;
	font-size: 10px;
}
.SearchBoxField {
	background-image:url(/common/images/search.gif);
	background-repeat: no-repeat;
	padding:2px 0 2px 17px;
	width: 140px !important;
        height: 14px !important;
}
.HeaderNavMore
{
	text-align: left; 
	background-color:white;
}

.formboxesReadOnly{
	font-family: Verdana, Arial, serif;
	background-color: #e9f5f5;
	color:#777;
	font-size: 8pt;
}

.textblack8 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 8px;
	color : black;
}
.textblack9 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 9px;
	color : black;
}
.textblack10 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 10px;
	color : black;
}
.textblack11 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 11px;
	color : black;
}
.textblack12 {
	font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 12px;
	color : black;
}
.textblack14 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 14px;
	color : black;
}
.textblack16 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 16px;
	color : black;
}
.textblack16bold {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 16px;
        color : black;
	font-weight: bold;
}

.textblack18 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 18px;
	color : black;
}

.textblue8 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 8px;
	color : #0033cc;
}
.textblue9 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 9px;
	color : #0033cc;
}
.textblue10 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 10px;
	color : #0033cc;
}
.textblue12 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 12px;
	color : #0033cc;
}
.textblue14 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 14px;
	color : #0033cc;
}
.textblue16 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 16px;
	color : #0033cc;
}
.textblue18 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 18px;
	color : #0033cc;
}

.textred8 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 8px;
	color : red;
}
.textred9 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 9px;
	color : red;
}
.textred10 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 10px;
	color : red;
}
.textred11 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 11px;
	color : red;
}
.textred12 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 12px;
	color : red;
}
.textred14 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 14px;
	color : red;
}
.textred16 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 16px;
	color : red;
}
.textred18 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 18px;
	color : red;
}
.textwhite8 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 8px;
	color : white;
}
.textwhite9 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 9px;
	color : white;
}
.textwhite10 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 10px;
	color : white;
}
.textwhite11 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 11px;
	color : white;
}
.textwhite12 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 12px;
	color : white;
}
.textwhite14 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 14px;
	color : white;
}
.textwhite16 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 16px;
	color : white;
}
.textwhite18 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 18px;
	color : white;
}

.textgreen9 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 9px;
	color : green;
}
.textgreen10 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 10px;
	color : green;
}
.textgreen11 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 11px;
	color : green;
}
.textgreen12 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 12px;
	color : green;
}
.textgreen14 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 14px;
	color : green;
}
.textgreen16 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 16px;
	color : green;
}
.textgreen18 {
        font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
        font-size : 18px;
	color : green;
}

.formboxes{
	font-family: Verdana, Arial, serif;
	background-color: #e9f5f5;
	font-size: 8pt;
}

.smallbuttons {
	font-family: geneva, arial, sans-serif;
	background-color: #e9f5f5;
	font-size: 7pt;
}
/*
Theme Name: IBSystems Default Theme
Theme URI: http://www.ibsystems.com
Description: The theme for IBS (non Share) sites. This theme will display your blogs with the "Cafe" look on our site.
Version: 1.0
Author: Nitai Fraenkel
Author URI: http://www.fraenkel.biz
Tags: Share dark, custom header, fixed width, three columns, widgets

        The CSS, XHTML and design is released under GPL:
        http://www.opensource.org/licenses/gpl-license.php


When            Who                             What
-----------     ------------    -------------------------
01-Nov-2023     Nitai           Add this header.

*/

/* Begin Typography & Colors */
body {
	font-size: 62.5%; /* Resets 1em to 10px */
	font-family: 'Lucida Grande', Verdana, Arial, Sans-Serif;
	/** background: #d5d6d7 url('images/kubrickbgcolor.jpg'); **/
	color: #333;
	text-align: center;
}
#page {
	background-color: white;
	text-align: left;
}
#header {
/**	background: #73a0c5 url('images/kubrickheader.jpg') no-repeat bottom center; **/
}
#headerimg {
	margin: 7px 9px 0px 0px;
	font-size: 12px;
}

#content {font-size: 12px;}

.widecolumn .entry p {
	font-size: 1.05em;
}

.narrowcolumn .entry, .widecolumn .entry {
	line-height: 1.4em;
	font-size: 12px;
}
.entryTop {margin-top:18px;}
.widecolumn {
	line-height: 1.4em;
}
.narrowcolumn .postmetadata {
	text-align: center;
}
.narrowcolumn {
	border-right: 1px solid #bebebe;
}
.thread-alt {
	background-color: #f8f8f8;
}
.thread-even {
	background-color: white;
}
.depth-1 {
border: 1px solid #ddd;
}
.even, .alt {
	border-left: 1px solid #ddd;
}
#footer {
	border: none;
}
small {
	font-family: Arial, Helvetica, Sans-Serif;
	font-size: 11px;
	line-height: 12px;
}
h1, h2, h3 {
	font-family: 'Trebuchet MS', 'Lucida Grande', Verdana, Arial, Sans-Serif;
	font-weight: bold;
}
h1 {
	font-size: 4em;
	text-align: center;
}
#headerimg .description {
	font-size: 1.2em;
	text-align: center;
}
h2 {	font-size: 20px;
}
h2.pagetitle {
	font-size: 20px;
}
.sidebar h2 {
	font-family: 'Lucida Grande', Verdana, Sans-Serif;
	font-size: 14px; /** 1.2em; **/
}
h3 {
	font-size: 1.3em;
}
h1, h1 a, h1 a:hover, h1 a:visited, #headerimg .description {
	text-decoration: none;
	color: white;
}
h2, h3, h3 a, h3 a:visited {
	color: #333;
}
h2, h2 a:hover, h3, h3 a, h3 a:hover, h3 a:visited, .sidebar h2, #wp-calendar caption, cite {
	text-decoration: none;
}
.entry p a:visited {
	color: #b85b5a;
}
.commentlist li, #commentform input, #commentform textarea {
	font: 0.9em 'Lucida Grande', Verdana, Arial, Sans-Serif;
}
.commentlist li ul li {
	font-size: 1em;
}
.commentlist li {
	font-weight: bold;
}
.commentlist li .avatar { 
	float: right;
	border: 1px solid #eee;
	padding: 2px;
	background: #fff;
}
.commentlist cite, .commentlist cite a {
	font-weight: bold;
	font-style: normal;
	font-size: 1.1em;
}

.commentlist p {
	font-weight: normal;
	line-height: 1.5em;
	text-transform: none;
}
#commentform p {
	font-family: 'Lucida Grande', Verdana, Arial, Sans-Serif;
}
.commentmetadata {
	font-weight: normal;
}
.sidebar {
	font: 10px 'Lucida Grande', Verdana, Arial, Sans-Serif;
}
small, .sidebar ul ul li, .sidebar ul ol li, .nocomments, .postmetadata, blockquote, strike {
	color: #777;
}
code {
	font: 1.1em 'Courier New', Courier, Fixed;
	}
acronym, abbr, span.caps
{
	font-size: 0.9em;
	letter-spacing: .07em;
}
a, h2 a:hover, h3 a:hover {
	color: #06c;
	text-decoration: none; 
}
a:hover {
	color: #147;
	text-decoration: underline;
}
#wp-calendar #prev a, #wp-calendar #next a {
	font-size: 9pt;
}
#wp-calendar a {
	text-decoration: none;
}
#wp-calendar caption {
	font: bold 13px 'Lucida Grande', Verdana, Arial, Sans-Serif;
	text-align: center;
}
#wp-calendar th {
	font-style: normal;
	text-transform: capitalize;
}
/* End Typography & Colors */

/* Begin Structure */
body {
	margin: 0 0 20px 0;
	padding: 0;
}
#page {
	background-color: white;
	margin: 20px auto; 
	padding: 0;
}
#header {
	background-color: #73a0c5;
	margin: 0 0 0 1px;
	padding: 0;
	height: 200px;
}

#headerimg {
	margin: 0;
	height: 200px;
	width: 100%;
}
.narrowcolumn {
	float: left;
	margin: 0px;
}
.widecolumn {
	padding: 0 0 5px 5px;
	margin: 0px 0 0;
}
.post {
	margin: 0 5px 40px 2px;
	text-align: justify;
}
.post hr {
	display: block;
}
.widecolumn .post {
	margin: 0;
}
.narrowcolumn .postmetadata {
	padding-top: 5px;
}
.widecolumn .postmetadata {
	margin: 30px 0;
}

.widecolumn .smallattachment {
	text-align: center;
	float: left;
	width: 128px;
	margin: 5px 5px 5px 0px;
}
.widecolumn .attachment {
	text-align: center;
	margin: 5px 0px;
}
.postmetadata {
	clear: both;
}
.clear {
	clear: both;
}

#footer {
	padding: 0;
	margin: 0 auto;
	clear: both;
}

#footer p {
	margin: 0;
	padding: 20px 0;
	text-align: center;
}
/* End Structure */

/*	Begin Headers */
h1 {
	padding-top: 70px;
	margin: 0;
}
h2 {
	margin: 30px 0 0;
}
h2.pagetitle {
	margin-top: 30px;
	text-align: center;
}
.sidebar h2 {
	margin: 5px 0 0;
	padding: 0;
}
h3 {
	padding: 0;
	margin: 30px 0 0;
}
h3.comments {
	padding: 0;
	margin: 40px auto 20px ;
}
/* End Headers */

/* Begin Images */
p img {
	padding: 0;
	max-width: 100%;
}
img.centered {
	display: block;
	margin-left: auto;
	margin-right: auto;
}
img.alignright {
	padding: 4px;
	margin: 0 0 2px 7px;
	display: inline;
}
img.alignleft {
	padding: 4px;
	margin: 0 7px 2px 0;
	display: inline;
}
.alignright {
	float: right;
}
.alignleft {
	float: left
}
/* End Images */

/* Begin Lists
	Special stylized non-IE bullets
	Do not work in Internet Explorer, which merely default to normal bullets. */

html>body .entry ul {
	margin-left: 0px;
	padding: 0 0 0 30px;
	list-style: none;
	padding-left: 10px;
	text-indent: -10px;
}
html>body .entry li {
	margin: 7px 0 8px 10px;
}
.entry ul li:before, .sidebar ul ul li:before {
	content: "\00BB \0020";
}
.entry ol {
	padding: 0 0 0 35px;
	margin: 0;
}
.entry ol li {
	margin: 0;
	padding: 0;
}
.postmetadata ul, .postmetadata li {
	display: inline;
	list-style-type: none;
	list-style-image: none;
}
.sidebar ul, .sidebar ul ol {
	margin: 0;
	padding: 0;
}
.sidebar ul li {
	list-style-type: none;
	list-style-image: none;
	margin-bottom: 15px;
}
.sidebar ul p, .sidebar ul select {
	margin: 5px 0 8px;
}
.sidebar ul ul, .sidebar ul ol {
	margin: 5px 0 0 10px;
}
.sidebar ul ul ul, .sidebar ul ol {
	margin: 0 0 0 10px;
}
ol li, .sidebar ul ol li {
	list-style: decimal outside;
}

.sidebar ul ul li, .sidebar ul ol li {
	margin: 3px 0 0;
	padding: 0;
}
/* End Entry Lists */

/* Begin Form Elements */
#searchform {
	margin: 10px auto;
	padding: 5px 3px;
	text-align: center;
}
.sidebar #searchform #s {
	width: 108px;
	padding: 2px;
}
.sidebar #searchsubmit {
	padding: 1px;
}
.entry form { /* This is mainly for password protected posts, makes them look better. */
	text-align:center;
}
select {
	width: 130px;
}
#commentform input {
	width: 170px;
	padding: 2px;
	margin: 5px 5px 1px 0;
}
#commentform {
	margin: 5px 10px 0 0;
}
#commentform textarea {
	width: 100%;
	padding: 2px;
}
#respond:after {
	content: "."; 
	display: block; 
	height: 0; 
	clear: both; 
	visibility: hidden;
}
#commentform #submit {
	margin: 0 0 5px auto;
	float: right;
}
/* End Form Elements */

/* Begin Comments*/
.alt {
	margin: 0;
	padding: 10px;
}
.commentlist {
	padding: 0;
	text-align: justify;
}
.commentlist li {
	margin: 15px 0 10px;
	padding: 5px 5px 10px 10px;
	list-style: none;
}
.commentlist li ul li { 
	margin-right: -5px;
	margin-left: 10px;
}
.commentlist p {
	margin: 10px 5px 10px 0;
}
.children { padding: 0; }
#commentform p {
	margin: 5px 0;
}
.nocomments {
	text-align: center;
	margin: 0;
	padding: 0;
}
.commentmetadata {
	margin: 0;
	display: block;
}
/* End Comments */

/* Begin Sidebar */
.sidebar
{
	/** padding: 20px 0 10px 0; **/
	padding: 5px 0 10px 0;
	margin-left: 645px;
	width: 190px;
}

.sidebar form {
	margin: 0;
}
/* End Sidebar */

/* Begin Calendar */
#wp-calendar {
	empty-cells: show;
	margin: 10px auto 0;
	width: 155px;
}
#wp-calendar #next a {
	padding-right: 10px;
	text-align: right;
}
#wp-calendar #prev a {
	padding-left: 10px;
	text-align: left;
}
#wp-calendar a {
	display: block;
}
#wp-calendar caption {
	text-align: center;
	width: 100%;
}
#wp-calendar td {
	padding: 3px 0;
	text-align: center;
}
#wp-calendar td.pad:hover { /* Doesn't work in IE */
	background-color: #fff;
}
/* End Calendar */

/* Begin Various Tags & Classes */
acronym, abbr, span.caps {
	cursor: help;
}
acronym, abbr {
	border-bottom: 1px dashed #999;
}
blockquote {
	margin: 15px 30px 0 10px;
	padding-left: 20px;
	border-left: 5px solid #ddd;
}
blockquote cite {
	margin: 5px 0 0;
	display: block;
}
.center {
	text-align: center;
}
.hidden {
	display: none;
}
hr {
	display: none;
}
a img {
	border: none;
}

.navigation {
	display: block;
	text-align: center;
	/** margin-top: 10px;
	margin-bottom: 60px; **/
	margin-top: 5px;
	margin-bottom: 20px;
}
/* End Various Tags & Classes*/

/* Captions */
.aligncenter,
div.aligncenter {
	display: block;
	margin-left: auto;
	margin-right: auto;
}
.wp-caption {
	border: 1px solid #ddd;
	text-align: center;
	background-color: #f3f3f3;
	padding-top: 4px;
	margin: 10px;
	-moz-border-radius: 3px;
	-khtml-border-radius: 3px;
	-webkit-border-radius: 3px;
	border-radius: 3px;
}
.wp-caption img {
	margin: 0;
	padding: 0;
	border: 0 none;
}
.wp-caption p.wp-caption-text {
	font-size: 11px;
	line-height: 17px;
	padding: 0 4px 5px;
	margin: 0;
}
/* End captions */

/** Added by IBS **/
#IBSBlogInfo {
	background: #fefefe;
	float: left;
	margin-top: 0px;
	margin-bottom: 10px;
}
#IBSBlogInfoPhoto {
	float: left;
}
.IBSBlogInfoText {
	margin: 5px;
	text-align: left;
	float: right;
	font-size: 12px;
	width: 542px;
}
.authorphoto {
	margin: 3px;
	width: 70px;
}
.blogbanner {
	margin-bottom: 20px;
}
.IBSBlogEntryText span{
	font-size: 8px;
}
.by_author {
	font-variant:normal; 
	font-weight: normal;
	font-size: 9px;
	font-family: Verdana, Arial, serif;
}
.widget {
	margin-bottom:20px;
}
.widget h4 {
	margin-bottom:5px;
}
.IBSAuthor {float:left}
/* ### .IBS_social_network {float:right; margin-right:5px; text-align:right;} ### */
.MobileMenuSideBarDtl {text-align:left; border:thin #bebebe solid; position:relative; z-index:100000 ;background-color:white; margin-right:5px; margin-top:120px;}
#sidebarPop {float:left;z-index:1000; margin-left: 5px; display:none;position:absolute;}
/* #### Mobile Phones Landscape #### */
@media screen and (max-device-width: 640px) and (orientation: landscape){
	#page, #header, #footer, .widecolumn, .IBSBlogEntry, .IBSBlogEntryText, #IBSBlogInfo {width:100%; }
	.blogbanner {width:430px;height:50px; margin-top:5px;}
	.narrowcolumn{width:100%; border:thin solid white;}
	.post{margin-right:5px;}
	a, img {max-width:100%; !importent}
	#tblGlobalWrapper {width:100%;margin-left:0px; margin-right: 10px;}
	#imgOpenSideBarMenu{width:40px; height:40px;}
	.IBSBlogEntry, .ShareBlogEntry, .IBSBlogEntryText, ShareBlogEntryText {font-size:10px;}
	.IBSBlogEntryTitle{font-size:12px;}
	.shareby_author, .by_author {font-size:9px;}
	#sidebarPop {margin-top:58px;}
	#sidebar{display:none;}
}
/* #### Mobile Phones Portrait #### */
@media screen and (max-device-width: 480px) and (orientation: portrait){
	#page, #header, #footer, .widecolumn, .IBSBlogEntry, .IBSBlogEntryText, #IBSBlogInfo {width:100%; }
	.blogbanner {width:260px;height:33px; margin-top:5px;}
	.narrowcolumn{width:100%; border:none;}
	.post{margin-right:5px;}
	a, img, iframe {max-width:100%; !importent}
	#tblGlobalWrapper {width:100%;margin-left:0px; margin-right: 10px;}
	#imgOpenSideBarMenu{width:33px; height:33px;}
	.IBSBlogEntry, .ShareBlogEntry, .IBSBlogEntryText, ShareBlogEntryText {font-size:10px;}
	.IBSBlogEntryTitle{font-size:12px;}
	.shareby_author, .by_author {font-size:9px;}
	#sidebarPop {margin-top:42px;}
	#sidebar{display:none;}
}
/* #### Desktops #### */
@media screen and (min-width: 1024px){
	#page {width: 850px;}
	#header {width: 758px;}
	.widecolumn {width: 525px;}
	.IBSBlogEntry {width:525px;}
	.IBSBlogEntryText {width:640px;}
	#IBSBlogInfo{width:630px;}
	.blogbanner {width:475px;height:50px;}
	#footer {width:760px;}
	.narrowcolumn{width:636px;}
	.post{width:610px;}
	#sidebar{display:block;}
	#imgOpenSideBarMenu{display:none;width:40px; height:40px;}
}
@media screen and (max-width: 1024px) and (min-device-width: 640px){
	.sidebar{display:none;}
	#imgOpenSideBarMenu{display:block;width:40px; height:40px; }
	.divMobileSizebarMenu{width:40px; height:40px; margin-right:12px;}
	#page, #header, #footer, .widecolumn, .IBSBlogEntry, .IBSBlogEntryText, #IBSBlogInfo {width:630px;}
	.post{width:630px;}
	.narrowcolumn, .ContentWidth {width:630px;}
	.narrowcolumn {border:none;}
	#sidebarPop {margin-top:58px;}

}

</style>
</head>
<BODY  BGCOLOR='white'>
<CENTER><table id='tblFrame' style='width:805px;'><tr><td>
<div style='float:right'>
<A HREF="https://www10.EDACafe.com/blogs/weekly/?ee=bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D&sk=6fbe2f&run_date=28-Feb-2025"  style='text-decoration:underline;font-size:10px;'>View in your browser</A></div><br clear=all>
<div style='width:805px; text-align:left; border:thin solid #cccccc; padding:5px;'>
<TABLE id='siteTopImageAndDate' CELLPADDING=0 CELLSPACING=0 BORDER='0' WIDTH='100%' >
	<TR>
	<TD ALIGN='left'>
	<A HREF="https://www10.EDACafe.com/common/images/11/11429/1740995992/bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D/at.html"><IMG SRC='https://www10.EDACafe.com/common/images/0/11429/1740995992/s.gif' ALT='EDACafe Weekly Review' BORDER=0></A>
	</TD>
	<TD align=right>
	<B><font style='font-size:13px; font-weight:900'>February 28th, 2025</font></B>
	</TD></TR>
	</TABLE><br>


	<div style='border-bottom:1px solid #ccc'>
<TABLE id='DisplayBannerHEADER' cellpadding=0 cellspacing=0 border=0 >
<TR style='vertical-align:top;' >
<TD  nowrap align='left'>
<TABLE id='Ad49379Tbl' BORDER='0' CELLPADDING='0' CELLSPACING='0' BGCOLOR='#FFFFFF' ><TR BGCOLOR='#FFFFFF'>
<TD nowrap align='left' >
<A HREF="https://EDACafe.com/common/images/10/30801/0303020010/bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D/at.html"  title="techjobscafe EDA Jobs" >
<IMG SRC='https://EDACafe.com/common/images/14/30801/49379/0303020010/0/bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D/s.gif' BORDER='0' HEIGHT='90' WIDTH='728' class='ImageBanner728x90' ALT="techjobscafe EDA Jobs"  TITLE="techjobscafe EDA Jobs"  /></A></TD>
		</TR>
	</TABLE>
</TD>
</TR>
</TABLE>
</CENTER>
	</div><table id='TwoColTbl' cellspacing=0 cellpadding=0 border=0 style='width:810px;text-align:left;'>
<tr><td valign=top>
<div id='content' style='line-height: normal; margin: 0px 0px 0px 1px; width: 620px;' >
<div  style='border-top:1px outset #101010;margin-top:15px;width:620px;'>
	<div id="postTitle-2-1682" style='margin-top:10px;'>
<a href="https://www10.edacafe.com/blogs/grahambell/2025/02/28/silicon-reimagined-the-next-era-of-ai-computing/" style='font-size:20px;font-weight:700;'>Silicon Reimagined: The Next Era of AI Computing</a><div style='font-size:12px;' > February 28, 2025 &nbsp;by Sanjay Gangal</div>
</div>

<div style='font-size:12px;'>
<p><strong>The Dawn of a New Computing Paradigm</strong><br />
For decades, the semiconductor industry has been defined by the predictable cadence of Moore’s Law, which steadily improved chip performance and efficiency. But as artificial intelligence (AI) reaches an inflection point—evolving from experimental curiosity to business-critical infrastructure—the industry is being forced to reimagine silicon from the ground up.</p>

<p>A new report from Arm, <a href="https://www.arm.com/resources/report/silicon-reimagined"><em>Silicon Reimagined: New Foundations for the Age of AI</em></a>, details this profound transformation. It explores how chip designers and technology leaders are responding to AI’s unprecedented computational demands while addressing critical challenges in power efficiency, security, and reliability.</p>
<h3>Breaking Free from Moore’s Law</h3>

<p>For years, the industry relied on the assumption that transistor density could continue to double every two years. That era is over. As traditional scaling approaches reach their physical and economic limits, chipmakers are embracing new architectures such as chiplets and compute subsystems (CSS) to keep pace with AI’s relentless need for power.</p>

<p>At the heart of this shift is an industry-wide move toward specialized silicon. The biggest cloud providers—including Amazon, Microsoft, and Google—are developing custom AI processors, optimized for handling massive AI models with greater efficiency than general-purpose chips. Meanwhile, companies like Arm are advancing heterogeneous computing architectures, balancing efficiency and performance with domain-specific accelerators.</p>
<h3>The New Power Play: Efficiency at Scale</h3>

<p>AI is an energy-hungry technology. Training a single AI model can consume as much power as hundreds of homes over its lifecycle. To mitigate this, silicon designers are prioritizing power efficiency through innovative memory hierarchies, advanced packaging, and dynamic power management techniques.</p>

<p>Memory hierarchies are playing an increasingly critical role, with high-bandwidth memory (HBM) and near-memory computing architectures helping to reduce latency and power consumption. Chip stacking, using 2.5D and 3D integration, allows for more efficient data movement, addressing a major bottleneck in AI computations.</p>

<p>At the same time, AI itself is being deployed to optimize power consumption at every level—from improving datacenter energy allocation to reducing redundancy in AI training models. The era of brute-force computation is giving way to intelligent, energy-aware AI systems that dynamically allocate resources based on workload demands.</p>
<h3>The Rising Threat of AI-Powered Cyberattacks</h3>

<p>AI is not only revolutionizing industries—it is also transforming the cybersecurity landscape. Emerging AI-driven cyber threats, including autonomous malware and AI-assisted phishing campaigns, are forcing chipmakers to rethink security at a fundamental level.</p>

<p>In response, semiconductor companies are embedding robust security features directly into hardware, including cryptographic safeguards, secure boot processes, and AI-enhanced threat detection. Confidential computing architectures, which isolate sensitive AI workloads from potential attackers, are becoming standard features in next-generation chips. Technologies such as memory tagging extensions (MTE) and secure enclaves ensure that AI models remain protected against exploitation.</p>
<h3>Redefining Chip Design in the AI Era</h3>

<p>The shift from monolithic chip design to modular, chiplet-based architectures marks one of the most significant transformations in semiconductor history. By allowing different components to be manufactured separately and then integrated, chiplets enable greater scalability, reduce costs, and open the door for more customized AI silicon.</p>

<p>However, this approach introduces new engineering challenges. Power delivery, thermal management, and data transfer efficiency between chiplets all require novel solutions. Standardization efforts are underway to ensure interoperability, with industry leaders working to develop universal chiplet interface protocols that facilitate seamless integration.</p>

<p>Arm’s role in this transformation is particularly notable. With a 35-year heritage in power-efficient chip designs, the company is leading the push toward more modular, scalable solutions that can accommodate the growing complexity of AI workloads.</p>
<h3>Software’s Expanding Role in Silicon Innovation</h3>

<p>AI silicon is only as effective as the software that runs on it. As custom silicon becomes more prevalent, software ecosystems must adapt to support new processor architectures without sacrificing compatibility and developer productivity.</p>

<p>The adoption of open AI frameworks, such as TensorFlow and PyTorch, has made it easier for developers to leverage specialized hardware without extensive code rewrites. Meanwhile, software-defined hardware—where AI models dynamically configure chip behavior—represents an exciting frontier in AI computing.</p>

<p>Interoperability across AI frameworks is a critical concern for developers. Embedded and IoT devices, particularly those designed for edge AI inference, often need to function across multiple hardware platforms. This is why developers frequently default to CPU back-ends, as their ubiquity helps ensure broader compatibility.</p>

<p>Cloud-based development environments are also transforming the landscape, offering access to extensive computing resources necessary for training large-scale models. While AI inference often happens at the edge, cloud-based training has become indispensable for managing the computational demands of modern AI workloads.</p>
<h3>A Collaborative Future for AI Silicon</h3>

<p>The success of AI-era silicon will increasingly depend on cross-industry collaboration. IP providers, foundries, and system integrators must work together to optimize compute, memory, and power delivery at a system level.</p>

<p>As AI adoption accelerates, the semiconductor industry must evolve in lockstep. This means moving beyond the constraints of Moore’s Law, embracing custom silicon, and developing power-efficient, secure, and scalable computing architectures.</p>

<p>Looking ahead, the integration of AI into chip design is poised to redefine what’s possible in computing. Machine learning (ML) techniques are already being used to optimize power efficiency, improve performance, and automate aspects of chip layout and verification. The interplay between AI and silicon will only deepen, creating a feedback loop where AI helps design the very chips that power AI applications.</p>

<p>The AI revolution is here, and the future of computing depends on our ability to reimagine silicon for this new age. With breakthroughs in chiplet technology, energy efficiency, security, and software compatibility, the industry is well-positioned to drive the next wave of AI innovation. The companies that successfully navigate this transformation will not only shape the future of AI but redefine the very fabric of computing itself.</p>

</div>
</div>

<div  style='border-top:1px outset #101010;margin-top:15px;width:620px;'>
	<div id="postTitle-33-5442" style='margin-top:10px;'>
<a href="https://www10.edacafe.com/blogs/guest/2025/02/26/ai-factories-are-reshaping-the-future-of-chip-design-verification-and-optimization/" style='font-size:20px;font-weight:700;'>AI Factories Are Reshaping the Future of Chip Design, Verification, and Optimization</a><div style='font-size:12px;' > February 26, 2025 &nbsp;by Sanjay Gangal</div>
</div>

<div style='font-size:12px;'><p data-start="155" data-end="592">The world is at the dawn of a new industrial revolution, one powered by artificial intelligence factories that are fundamentally changing how chips are designed, verified, and optimized. At the Design and Verification Conference (DVCon) 2025 in San Jose, industry leaders from Synopsys and Microsoft outlined how AI is driving an era of rapid transformation, forcing semiconductor companies to rethink every aspect of chip development.</p>
<p data-start="155" data-end="592"><a href="https://www10.edacafe.com/blogs/guest/files/2025/02/1.jpg"><img decoding="async" loading="lazy" class="aligncenter size-medium wp-image-5443" src="https://www10.edacafe.com/blogs/guest/files/2025/02/1-300x231.jpg" alt="" width="300" height="231" srcset="https://www10.edacafe.com/blogs/guest/wp-content/blogs.dir/33/files/2025/02/1-300x231.jpg 300w, https://www10.edacafe.com/blogs/guest/wp-content/blogs.dir/33/files/2025/02/1.jpg 562w" sizes="(max-width: 300px) 100vw, 300px" /></a></p>
<p data-start="594" data-end="970">Speaking at the keynote session, Ravi Subramanian, Chief Product Management Officer, Systems Design Group at Synopsys, and Artour Levin, Vice President of AI Silicon Engineering at Microsoft, described how AI’s pervasive intelligence is now a primary driver of economic growth, touching industries from automotive and robotics to data centers and high-performance computing.</p>
<p data-start="972" data-end="1220">With chip complexity skyrocketing and workloads becoming increasingly software-defined, the speakers emphasized that new AI-assisted methodologies are essential to meet power, performance, and time-to-market demands in the semiconductor industry.</p>
<p data-start="972" data-end="1220"> <a href="https://www10.edacafe.com/blogs/guest/2025/02/26/ai-factories-are-reshaping-the-future-of-chip-design-verification-and-optimization/#more-5442" class="more-link"><!-- IBS Next Page --></a></p>

<div style='width:620px; margin: 10px 2px 15px 30px; text-align: left;'>
<a HREF="https://www10.edacafe.com/blogs/guest/2025/02/26/ai-factories-are-reshaping-the-future-of-chip-design-verification-and-optimization/"  style='text-decoration: underline; float: right; display: inline;  margin-right:10px;'><img src='https://www10.EDACafe.com/common/images/next_page.png' width=79 height=20 alt='Read the full article' title='Read the full article'/></a>
</div></div>
</div>

<div  style='border-top:1px outset #101010;margin-top:15px;width:620px;'>
	<div id="postTitle-165-267" style='margin-top:10px;'>
<a href="https://www10.edacafe.com/blogs/siemens/2025/02/24/a-shift-left-strategy-to-tackle-the-complexities-of-power-domain-leakage-in-ic-design/" style='font-size:20px;font-weight:700;'>A shift-left strategy to tackle the complexities of power domain leakage in IC design</a><div style='font-size:12px;' > February 24, 2025 &nbsp;by Sanjay Gangal</div>
</div>

<div style='font-size:12px;'>
<p><em>Author: Matthew Hogan</em></p>

<p><strong>A shift-left strategy to tackle the complexities of power domain leakage in IC design </strong></p>

<p>Managing leakage power is a critical challenge for IC designers, as it can profoundly impact a device&#8217;s power, performance, area (PPA) and overall reliability. Leakage can manifest in various ways, from analog gate leakage causing high current drain to digital gate leakage leading to power management and reliability issues. Even subtle circuit changes can introduce leakage problems that compromise the final product. Traditionally, designers have left verification of these leakage issues until later design stages, resulting in costly rework. However, a shift-left approach that integrates leakage and reliability analysis into the pre-layout phase can help identify and address potential problems early on. By leveraging advanced EDA tools that take a holistic view of the circuit, designers can get ahead of leakage challenges and ensure their ICs meet the highest standards of quality and reliability.</p>

<p> <a href="https://www10.edacafe.com/blogs/siemens/2025/02/24/a-shift-left-strategy-to-tackle-the-complexities-of-power-domain-leakage-in-ic-design/#more-267" class="more-link"><!-- IBS Next Page --></a></p>
<div class="sharedaddy sd-sharing-enabled"><div class="robots-nocontent sd-block sd-social sd-social-icon-text sd-sharing"><h3 class="sd-title">Share this:</h3><div class="sd-content"><ul><li class="share-facebook"><a rel="nofollow noopener noreferrer" data-shared="sharing-facebook-267" class="share-facebook sd-button share-icon" href="https://www10.edacafe.com/blogs/siemens/2025/02/24/a-shift-left-strategy-to-tackle-the-complexities-of-power-domain-leakage-in-ic-design/?share=facebook"  title="Click to share on Facebook" ><span>Facebook</span></a></li><li class="share-x"><a rel="nofollow noopener noreferrer" data-shared="sharing-x-267" class="share-x sd-button share-icon" href="https://www10.edacafe.com/blogs/siemens/2025/02/24/a-shift-left-strategy-to-tackle-the-complexities-of-power-domain-leakage-in-ic-design/?share=x"  title="Click to share on X" ><span>X</span></a></li><li class="share-end"></li></ul></div></div></div>
<div style='width:620px; margin: 10px 2px 15px 30px; text-align: left;'>
<a HREF="https://www10.edacafe.com/blogs/siemens/2025/02/24/a-shift-left-strategy-to-tackle-the-complexities-of-power-domain-leakage-in-ic-design/"  style='text-decoration: underline; float: right; display: inline;  margin-right:10px;'><img src='https://www10.EDACafe.com/common/images/next_page.png' width=79 height=20 alt='Read the full article' title='Read the full article'/></a>
</div></div>
</div>

</div>
</td><td valign='top'>
<TABLE id='DisplayBannerFOOTER' cellspacing=1 cellpadding=1 border=0 >
<TR VALIGN=top>
<TD  nowrap align='left'>
<TABLE id='Ad58978Tbl' BORDER='0' CELLPADDING='0' CELLSPACING='0' BGCOLOR='#FFFFFF' ><TR BGCOLOR='#FFFFFF'>
<TD nowrap align='left' >
<A HREF="https://EDACafe.com/common/images/10/40095/0303020010/bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D/at.html"  title="Verific: SystemVerilog & VHDL Parsers" >
<IMG SRC='https://EDACafe.com/common/images/14/40095/58978/0303020010/0/bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D/s.gif' BORDER='0' HEIGHT='125' WIDTH='125' class='ImageBanner125x125' ALT="Verific: SystemVerilog & VHDL Parsers"  TITLE="Verific: SystemVerilog & VHDL Parsers"  /></A></TD>
		</TR>
	</TABLE>
</TD>
</TR><TR VALIGN=top>
<TD style='padding-top:3px;'  nowrap align='left'>
<TABLE id='Ad58731Tbl' BORDER='0' CELLPADDING='0' CELLSPACING='0' BGCOLOR='#FFFFFF' ><TR BGCOLOR='#FFFFFF'>
<TD nowrap align='left' >
<A HREF="https://EDACafe.com/common/images/10/38353/0303020010/bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D/at.html"  title="Post your job postings here!" >
<IMG SRC='https://EDACafe.com/common/images/14/38353/58731/0303020010/0/bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D/s.gif' BORDER='0' HEIGHT='600' WIDTH='160' class='ImageBanner160x600' ALT="Post your job postings here!"  TITLE="Post your job postings here!"  /></A></TD>
		</TR>
	</TABLE>
</TD>
</TR></TABLE>
</td></tr></table><style>
#wpadminbar {display:none;}
</style>

	<br>
<br>

	<TABLE CELLPADDING=5 CELLSPACING=1 WIDTH=100% style='border: thin solid #cccccc;'>
	<TR VALIGN=TOP>
	<TD>
<span style='font-size:10px;'>You are registered as: [linux-kernel@vger.kernel.org].<br>
<br>

CafeNews is a service for EDA professionals. EDACafe.com respects your online time and Internet privacy.  <A HREF="https://EDACafe.com/nl/newsletter_subscribe.php?action=Edit&ee=bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D&sk=6fbe2f"  style='text-decoration:underline'>Edit or Change</A> my newsletter's profile details. <A HREF="https://EDACafe.com/nl/unsubscribe.php?ee=bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw%3D%3D&sk=6fbe2f"  style='text-decoration:underline'>Unsubscribe</A> me from this newsletter. <br>
<br/>
Copyright &copy; 2025, Internet Business Systems, Inc. &mdash; 670 Aberdeen Way Milpitas, CA 95035 &mdash; +1 (408) 882-6554 &mdash; All rights reserved. </span>
</TD>
	</TR>
	</TABLE>
</td></tr></table>
</CENTER>
	</BODY>
	</HTML>

--4d44677d2aa5b6b3ce62181b043179ed_htmlalt--
--4d44677d2aa5b6b3ce62181b043179ed--



